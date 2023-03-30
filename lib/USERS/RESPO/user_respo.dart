import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../MODEL/user_model.dart';

class UserRespo {
  ScrollController scrollController = ScrollController();
  int pages = 1;
  bool isLoadingMore = false;

  List<UserModel> userList = [];

  fecthData({page}) async {
    List<UserModel> tempuserList = [];
    isLoadingMore = await true;

    var p = await pages++;

    var url = Uri.parse("https://reqres.in/api/users?page=${p}");
    print(url);
    print(isLoadingMore);
    var response = await http.get(url);
    print(response);
    try {
      var decodeDetails = json.decode(response.body);
      print(decodeDetails["data"]);
      print(decodeDetails["data"].runtimeType);
      List datas = decodeDetails["data"];
      tempuserList = datas
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
      userList = userList + tempuserList;
      isLoadingMore = await false;
      print(isLoadingMore);
      return userList;
    } catch (e) {
      print("error in service $e");
    }
  }
}
