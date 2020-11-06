import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:structure_flutter_mobile/data/model/user.dart';

class ListUserPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ListUserPageState();
  }
}

class ListUserPageState extends State<ListUserPage> {
  ScrollController _scrollController;
  List<User> users = List<User>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener((_onScroll));

    for(int i = 0; i<25; i++) {
      users.add(User(i,"Name $i", "link$i"));
    }
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
                child: Text(users[pos].name, style: TextStyle(
                  fontSize: 18.0,
                  height: 1.6,
                ),),
              ),
            )
        );
      },
    );
  }

  _onScroll() {
    log("scroll");
  }
}


