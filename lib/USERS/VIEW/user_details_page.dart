import 'package:flutter/material.dart';
import 'package:reguserapp/USERS/MODEL/user_model.dart';

class UserDetailsPage extends StatefulWidget {
  UserModel? userModel;

  UserDetailsPage({this.userModel});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text("User Details"),
      ),
      body: Container(
        height: h,
        width: w,
        child: Column(
          children: [
            Container(
                height: h * 0.3,
                width: w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: h * 0.2,
                  foregroundImage: NetworkImage(
                    "${widget.userModel!.image}",
                  ),
                )),
            Expanded(
              child: Container(
                width: w,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    buildContainer(h, w,
                        txt: "User Name : ",
                        txt1:
                            "${widget.userModel!.firstName} ${widget.userModel!.lastName}"),
                    buildContainer(h, w,
                        txt: "First Name : ",
                        txt1: widget.userModel!.firstName),
                    buildContainer(h, w,
                        txt: "Last Name : ", txt1: widget.userModel!.lastName),
                    buildContainer(h, w,
                        txt: "Email : ", txt1: widget.userModel!.mail),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(double h, double w, {txt, txt1}) {
    return Container(
      height: h * 0.1,
      width: w,
      child: Row(
        children: [
          Text(
            "$txt",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text("$txt1"),
        ],
      ),
    );
  }
}
