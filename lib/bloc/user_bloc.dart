import 'dart:async';

import 'package:algodoc_app/models/models.dart';
import 'package:algodoc_app/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLogin) {
      UserModel userModel = await AuthService.signInWithGoogle();
      if (userModel != null) {
        Get.offAllNamed('/home');
      }
      yield UserLoaded(userModel: userModel);
    } else if (event is UserChecking) {
      UserModel userModel = await AuthService.checkCurrentAccount();
      if (userModel != null) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/signin');
      }
      yield UserLoaded(userModel: userModel);
    } else if (event is SignOutUser) {
      AuthService.signOut();
      Get.offAllNamed('/signin');
      yield UserSignedOut();
    }
  }
}
