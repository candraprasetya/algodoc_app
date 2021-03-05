part of 'screens.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UserChecking());
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
