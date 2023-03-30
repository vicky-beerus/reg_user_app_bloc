part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserEvent extends UserEvent {
  // final int page;
  // GetUserEvent({required this.page});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScrollGetEvent extends UserEvent {
  // final int page;
  // ScrollGetEvent({required this.page});

  @override
  List<Object?> get props => [];
}
