import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_state.dart';
import 'package:instaclonebloc/presantation/bloc/sign_up/signup_event.dart';
import 'package:instaclonebloc/presantation/bloc/sign_up/signup_state.dart';

import '../../pages/home_page.dart';
import '../../pages/sign_in_page.dart';
import '../home/home_bloc.dart';
import '../sign_in/signin_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  var fullnameController =TextEditingController();
  var cpasswordController=TextEditingController();

  bool isLoading= false;
  
  SignUpBloc(): super(SignUpInitialState()){
    on<CallHomePageEvent>(_onCallHomePageEvent);
  }

  Future<void>_onCallHomePageEvent(CallHomePageEvent event, Emitter<SignUpState> emit)async{
    emit(SignUpInitialState());
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
        create: (context)=> SignInBloc(),
        child: SignInPage(),
      );
    }));
  }
}