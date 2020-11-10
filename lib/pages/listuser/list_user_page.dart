import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:structure_flutter_mobile/data/model/user.dart';
import 'package:structure_flutter_mobile/data/source/remote/datasource/user_remote_datasource.dart';
import 'package:structure_flutter_mobile/data/source/remote/service/dio_client.dart';
import 'package:structure_flutter_mobile/repositories/user_repository.dart';

class ListUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListUserPageState();
  }
}

class ListUserPageState extends State<ListUserPage> {
  final _thresholdPixel = 200.0; // pixel
  final int limitPerPage = 10; // limit data in a request
  String keyword = "daol";
  int page = 0;
  bool canRequest = true;

  UserRepository _userRepository;
  ScrollController _scrollController;

  List<User> users = List<User>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener((_onScroll));

    DioClient client = DioClient("https://api.github.com");
    _userRepository = UserRepositoryImpl(UserRemoteDataSourceImpl(client));
    _fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: users.length,
      itemBuilder: (context, pos) {
        return Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Text(
                  users[pos].name,
                  style: TextStyle(
                    fontSize: 18.0,
                    height: 1.6,
                  ),
                ),
              ),
            ));
      },
    );
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _thresholdPixel && canRequest) {
      page++;
      _fetchData();
    }
  }

  _fetchData() async {
    canRequest = false;
    _userRepository
        .searchUsers(keyword, page: page, limit: limitPerPage)
        .then((value) {
      value.when(onSuccess: (data) {
        setState(() {
          canRequest = true;
          // no data to request
          if (data.length < 10) canRequest = false;
          users.addAll(data);
        });
      }, onFailure: (e) {
        log("QQQ" + e.errorMessage);
      });
    });
  }
}
