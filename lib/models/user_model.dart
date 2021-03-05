part of 'models.dart';

class UserModel extends Equatable {
  final String uid;
  final String username;
  final String email;
  final String photoUrl;

  UserModel({this.uid, this.username, this.email, this.photoUrl});

  @override
  List<Object> get props => [uid, username, email, photoUrl];
}
