part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final UserModel userModel;

  UserLoaded({this.userModel});

  List<Object> get props => [userModel];
}

class UserChecked extends UserState {}
class UserSignedOut extends UserState {}