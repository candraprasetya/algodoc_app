part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserLogin extends UserEvent {}

class LoadUserData extends UserEvent {}

class UserChecking extends UserEvent {}
class SignOutUser extends UserEvent {}