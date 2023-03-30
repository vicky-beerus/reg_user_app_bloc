part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserEvent extends UserEvent {


  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScrollGetEvent extends UserEvent {


  @override
  List<Object?> get props => [];
}
