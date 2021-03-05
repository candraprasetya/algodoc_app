part of 'screens.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack(
        [
          Image.asset('assets/logo.png'),
        ],
        alignment: MainAxisAlignment.center,
        crossAlignment: CrossAxisAlignment.center,
      ).whFull(context),
    );
  }
}
