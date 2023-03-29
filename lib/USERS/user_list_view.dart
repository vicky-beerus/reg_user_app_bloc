import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reguserapp/USERS/BLOC/user_bloc.dart';
import 'package:reguserapp/USERS/RESPO/user_respo.dart';


class UserListPage extends StatelessWidget {
  UserListPage({Key? key}) : super(key: key);

ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {

      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        print("its ture");
        context.read<UserBloc>().add(ScrollGetEvent());
      }else{
        print("its false");
      }

    });
    var h = MediaQuery
        .of(context)
        .size
        .height;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return BlocProvider(
      create: (context) =>
      UserBloc(userRespo: RepositoryProvider.of<UserRespo>(context))
        ..add(GetUserEvent(page: 1)),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Users List"),
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if(state is UserInitial){
                return Container(
                  alignment: Alignment.centerLeft,
                  child: CircularProgressIndicator(),
                );
              }
              if(state is UserLoadedState){
                return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
// controller: RepositoryProvider.of<UserRespo>(context).scrollController,
                          itemCount: state.data!.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Container(
                                height: h * 0.15,
                                width: w * 0.9,

                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: h * 0.15,
                                      width: w * 0.3,

                                      padding: EdgeInsets.all(15),
                                      child: CircleAvatar(
                                         
foregroundImage:NetworkImage("${state.data![index].image}",scale: 2)

                                      ),
                                    ),
                                    Expanded(
                                      child: Container(

                                        padding: EdgeInsets.all(10),
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,

height: h*0.06
                                               , child: Text("${state.data![index].firstName} ${state.data![index].lastName}")),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                height: h*0.06,
                                                child: Text("Email : ${state.data![index].mail}")),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },)
                        ,
                      )

                    ]);
              }
              if(state is UserErrorState){
                return Container(
                  alignment: Alignment.center,
                  child: Text("${state.er_msg}"),
                );
              }
              return SizedBox();
            },
          )),
    );
  }
}
