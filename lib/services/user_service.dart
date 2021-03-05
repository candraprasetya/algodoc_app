part of 'services.dart';

class UserService {
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> uploadUserData(UserModel user) async {
    userCollection.doc(user.uid).set({
      'uid': user.uid,
      'username': user.username,
      'email': user.email,
      'photoUrl': user.photoUrl,
    });
  }
}
