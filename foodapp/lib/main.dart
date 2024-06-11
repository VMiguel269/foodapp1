import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'homepage.dart';
import 'cadastro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCOZtpZ8MuZgYJu-SGqn5Dzfc9YC2SdYZs',
    appId: '1:220188271090:android:dd70a8d1644fcf2b148b6b',
    messagingSenderId: '220188271090',
    projectId: 'foodapp-4de28',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/cadastro': (context) => CadastroScreen(),
      },
    );
  }
}
