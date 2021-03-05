part of 'services.dart';

class AuthService {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final GetStorage getStorage = GetStorage();

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Future<UserModel> checkCurrentAccount() async {
    UserModel userModel;
    if (auth.currentUser != null) {
      print(auth.currentUser.uid);
      userModel = UserModel(
        email: auth.currentUser.email,
        photoUrl: auth.currentUser.photoURL,
        uid: auth.currentUser.uid,
        username: auth.currentUser.displayName,
      );
    }
    return userModel;
  }

  static Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);
      UserModel userModel = UserModel(
          uid: user.user.uid,
          email: user.user.email,
          username: user.user.displayName,
          photoUrl: user.user.photoURL);

      await getStorage.write('UID', user.user.uid);

      await UserService.uploadUserData(userModel);

      return userModel;
    } catch (e) {
      return UserModel();
    }
  }
}
