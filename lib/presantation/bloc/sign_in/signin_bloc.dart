import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/sigin_event.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_state.dart';
import 'package:instaclonebloc/presantation/pages/home_page.dart';
import 'package:instaclonebloc/presantation/pages/sign_up_page.dart';

import '../sign_up/signup_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLoading = false;

  SignInBloc() : super(SignInInitialState()) {
    on<CallSignUpEvent>(_onCallSignUpEvent);
  }

  Future<void>_onCallSignUpEvent(CallSignUpEvent event, Emitter<SignInState> emit)async{
    emit(SignInInitialState());
  }

  void callHomePage(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
      return BlocProvider(
        create: (context)=> HomeBloc(),
        child: HomePage(),
      );
    }));
  }

  void callSignUpPage(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
      return BlocProvider(
        create: (context)=> SignUpBloc(),
        child: SignUpPage(),
      );
    }));
  }
}
