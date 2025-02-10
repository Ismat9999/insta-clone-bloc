import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/splash/splash_event.dart';
import 'package:instaclonebloc/presantation/bloc/splash/splash_state.dart';
import 'package:instaclonebloc/presantation/pages/home_page.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/log_service.dart';
import '../../../core/services/notif_service.dart';
import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/local/prefs_service.dart';
import '../../pages/sign_in_page.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoadedState()) {
    on<SplashWaitEvent>(_onSplashWaitEvent);
  }

  Future<void> _onSplashWaitEvent(
      SplashWaitEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(SplashLoadedState());
  }

  callNextPage(BuildContext context) {
    if (AuthService.isLoggedIn()) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => HomeBloc(),
                    child: HomePage(),
                  )));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => SignInBloc(),
          child: SignInPage(),
        );
      }));
    }
  }

  void loadDeviceParams() async {
    var result = await UtilsService.deviceUniqueId();
    LogService.i(result.toString());
  }

  void initNotification() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      LogService.i('User granted permission');
    } else {
      LogService.e('User declined or has not accepted permission');
    }
    firebaseMessaging.getToken().then((value) async {
      String fcmToken = value.toString();
      PrefsService.saveFCMToken(fcmToken);
      String token = await PrefsService.loadFCMToken();
      LogService.i("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification!.title.toString();
      String body = message.notification!.body.toString();
      LogService.i(title);
      LogService.i(body);
      NotifService().showLocalNotification(title, body);
    });
  }
}
