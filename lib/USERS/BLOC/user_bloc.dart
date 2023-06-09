import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../MODEL/user_model.dart';
import '../RESPO/user_respo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRespo userRespo;

  UserBloc({required this.userRespo}) : super(UserInitial()) {
    on(_onFetchUser);

  }

  _onFetchUser(GetUserEvent event, Emitter<UserState> emit) async {
    // emit(UserInitial());

    // if (state is UserInitial) {
    try {
      final userData = await userRespo.fecthData();
      print("from bloc");
      print(userData);
      emit(UserLoadedState(data: userData));
      // await userRespo.scrollCaller();
    } catch (e) {
      emit(UserErrorState(er_msg: e.toString()));
    }
    // }
  }

}
