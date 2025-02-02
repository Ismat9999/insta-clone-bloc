import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/splash/splash_bloc.dart';
import 'package:instaclonebloc/presantation/pages/splash_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDYuDAcDje9icwN_UHLL_v1tMqXVmoUGAM',
      appId: '1:285125000262:android:a083ffb9a1b84af7855e47',
      messagingSenderId: '285125000262',
      projectId: 'instaclone-bloc',
      storageBucket: "instaclone-bloc.firebasestorage.app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:BlocProvider(
        create: (context)=> SplashBloc(),
        child: SplashPage(),
      ),
    );
  }
}

