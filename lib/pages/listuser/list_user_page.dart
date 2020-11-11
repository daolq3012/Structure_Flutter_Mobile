import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_flutter_mobile/bloc/blocs/search_users_bloc.dart';
import 'package:structure_flutter_mobile/bloc/events/search_users_event.dart';
import 'package:structure_flutter_mobile/bloc/states/search_users_state.dart';
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
  ScrollController _scrollController;

  bool isFetching = false;

  SearchUserBloc _searchUserBloc;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener((_onScroll));
    DioClient client = DioClient("https://api.github.com");
    UserRepository _userRepository =
        UserRepositoryImpl(UserRemoteDataSourceImpl(client));
    _searchUserBloc = SearchUserBloc(_userRepository);

    _searchUserBloc.add(FetchUsersEvent());
  }

  @override
  void dispose() {
    // _searchUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              child: Text(
                "ABC",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Expanded(
                child: BlocBuilder(
              cubit: _searchUserBloc,
              builder: _builderBloc,
            ))
          ],
        ),
      ),
    );
  }

  _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _thresholdPixel) {
      if (!isFetching) {
        isFetching = true;
        _searchUserBloc.add(FetchUsersEvent());
      }
    }
  }

  Widget _builderBloc(BuildContext context, SearchUserState state) {
    if (state is SearchUserInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is SearchUserError) {
      isFetching = false;
      return Center(
        child: Text('failed to fetch users'),
      );
    }
    if (state is SearchUserLoaded && state.users.isNotEmpty) {
      isFetching = false;
      return _buildListView(state);
    }
    return Center(
      child: Text('no users'),
    );
  }

  _buildListView(SearchUserLoaded state) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return index == state.users.length
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: SizedBox(
                          width: size.width * 0.2,
                          height: size.height * 0.1,
                          child: Stack(
                            children: [
                              Center(child: CircularProgressIndicator()),
                              Image(
                                image: NetworkImage(
                                  state.users[index].avatar,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          state.users[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black87,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
        itemCount:
            state.hasReachMax ? state.users.length : state.users.length + 1);
  }
}
