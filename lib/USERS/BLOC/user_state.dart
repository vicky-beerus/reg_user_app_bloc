part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState{
  List<UserModel> data;

 UserLoadedState({required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

class UserErrorState extends UserState{
  String? er_msg;
  UserErrorState({this.er_msg});
  @override
  // TODO: implement props
  List<Object?> get props => [er_msg];
}