import 'package:crypto_invest/view/screens/home_screen.dart';
import 'package:crypto_invest/view/widgets/app_loading.dart';
import 'package:crypto_invest/view_model/main_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) throw UnimplementedError();
        if (snapshot.connectionState == ConnectionState.done)
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MainViewModel(),
              ),
            ],
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => MainViewModel()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            ),
          );
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: AppLoading(),
          ),
        );
      },
    );
  }
}
