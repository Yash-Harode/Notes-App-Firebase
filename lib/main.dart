import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:codeland/screens/home_page.dart';
import 'package:codeland/theme/colors.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBWOjUhXG3XR8u1sRRTtYj809slKrZdYVM",
          appId: "1:348801637511:android:b31909d3f8d9e48599ec22",
          messagingSenderId: "348801637511",
          projectId: "notes-yash"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: primaryColor, brightness: Brightness.dark),
      home: const HomePage(),
    );
  }
}
