import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reguserapp/USERS/BLOC/user_bloc.dart';
import 'package:reguserapp/USERS/RESPO/user_respo.dart';
import 'package:reguserapp/USERS/VIEW/user_details_page.dart';

class UserListPage extends StatefulWidget {
  UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("Users List"),
        ),
        body: BlocProvider(
          create: (context) =>
              UserBloc(userRespo: RepositoryProvider.of<UserRespo>(context))
                ..add(GetUserEvent()),
          child: UserRegLists(h: h, w: w),
        ));
  }
}

class UserRegLists extends StatefulWidget {
  const UserRegLists({
    super.key,
    required this.h,
    required this.w,
  });

  final double h;
  final double w;

  @override
  State<UserRegLists> createState() => _UserRegListsState();
}

class _UserRegListsState extends State<UserRegLists> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    onScroll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadedState) {
          final snackBar = SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.amber,
            content: Text("Data Loaded"),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoadedState) {
            return Column(children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      RepositoryProvider.of<UserRespo>(context, listen: true)
                                  .isLoadingMore ==
                              true
                          ? state.data!.length + 1
                          : state.data!.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.data!.length) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsPage(
                                        userModel: state.data![index],
                                      )));
                        },
                        child: Card(
                          child: Container(
                            height: widget.h * 0.15,
                            width: widget.w * 0.9,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: widget.h * 0.15,
                                  width: widget.w * 0.3,
                                  padding: EdgeInsets.all(15),
                                  child: CircleAvatar(
                                      foregroundImage: NetworkImage(
                                          "${state.data![index].image}",
                                          scale: 2)),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            height: widget.h * 0.06,
                                            child: Text(
                                                "${state.data![index].firstName} ${state.data![index].lastName}")),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            height: widget.h * 0.06,
                                            child: Text(
                                                "Email : ${state.data![index].mail}")),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: widget.h * 0.15,
                        width: widget.w * 0.9,
                        color: Colors.red,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              )
            ]);
          }
          if (state is UserErrorState) {
            return Container(
              alignment: Alignment.center,
              child: Text("${state.er_msg}"),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  onScroll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("its ture");

        context.read<UserBloc>().add(GetUserEvent());
      } else {
        print("its false");
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
