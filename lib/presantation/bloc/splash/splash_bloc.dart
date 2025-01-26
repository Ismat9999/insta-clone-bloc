
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/splash/splash_event.dart';
import 'package:instaclonebloc/presantation/bloc/splash/splash_state.dart';
import 'package:instaclonebloc/presantation/pages/home_page.dart';

import '../../pages/sign_in_page.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState>{
SplashBloc(): super(StarterInitialState()) {
  on<CallPageEvent>(_onStartPageEvent);
}
  Future<void> _onStartPageEvent(CallPageEvent event, Emitter<SplashState> emit)async {
    emit(StarterInitialState());
  }
    void initTimer(BuildContext context) {
      Timer(const Duration(seconds: 2), () {
        callNextPage(context);
      });
    }
    callNextPage(BuildContext context) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => SignInBloc(),
          child: SignInPage(),
        );
      }));
    }
  }

//   callNextPage(){
//     Get.off(SignInPage());
//   }
//
//   void initTimer(){
//     Timer(const Duration(seconds: 2),(){
//       callNextPage();
//     });
//   }
// }
