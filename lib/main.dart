import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zartek_machine/features/authentication/screen/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/authentication/screen/splash_screen.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zartek',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

