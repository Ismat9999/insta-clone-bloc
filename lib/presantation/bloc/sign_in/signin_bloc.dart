import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_event.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_state.dart';
import 'package:instaclonebloc/presantation/pages/home_page.dart';
import 'package:instaclonebloc/presantation/pages/sign_up_page.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/local/prefs_service.dart';
import '../sign_up/signup_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLoading = false;

  SignInBloc() : super(SignInInitialState()){
    on<CallHomeEvent>(_onCallHomeEvent);
  }

  Future<void>_onCallHomeEvent(CallHomeEvent event, Emitter<SignInState> emit)async{
    emit(SignInInitialState());
  }

  void callHomePage(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => HomeBloc(),
        child: HomePage(),
      );
    }));
  }

  void callSignUpPage(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => SignUpBloc(),
        child: SignUpPage(),
      );
    }));
  }
  void doSignIn(BuildContext context) async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    isLoading = true;

    User? firebaseUser =await AuthService.signInUser(context, email, password);

    if(firebaseUser != null) {
      PrefsService.saveUserId(firebaseUser.uid);
      callHomePage(context);
    }else{
      UtilsService.fireToast("Please check your email and password again!");
    }

    isLoading = false;
  }
}
