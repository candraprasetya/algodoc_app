import 'package:algodoc_app/bloc/blocs.dart';
import 'package:algodoc_app/bloc/chat_bloc.dart';
import 'package:algodoc_app/screens/screens.dart';
import 'package:algodoc_app/services/services.dart';
import 'package:algodoc_app/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.getStorage.initStorage;
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> init = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error : ${snapshot.error}')),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => UserBloc()),
                BlocProvider(create: (context) => ChatBloc()),
              ],
              child: GetMaterialApp(
                title: 'AlgoChat!',
                theme: ThemeData(
                    primaryColor: colors.bluePrimary,
                    backgroundColor: Color(0xFFFAFAFC),
                    visualDensity: VisualDensity.adaptivePlatformDensity),
                getPages: [
                  GetPage(name: '/', page: () => Wrapper()),
                  GetPage(name: '/signin', page: () => SignInScreen()),
                  GetPage(name: '/home', page: () => HomeScreen()),
                  GetPage(name: '/video', page: () => VideoScreen()),
                ],
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
