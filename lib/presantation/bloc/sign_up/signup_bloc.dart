import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_state.dart';
import 'package:instaclonebloc/presantation/bloc/sign_up/signup_event.dart';
import 'package:instaclonebloc/presantation/bloc/sign_up/signup_state.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/local/prefs_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/member_model.dart';
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

  void doSignUp(BuildContext context) async {
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty ||
        cpassword.isEmpty){
      UtilsService.fireToast("Please fill out your information!");
      return;
    }

    if (password != cpassword){
      UtilsService.fireToast("Your password did not match!");
      return;
    }

    isLoading= true;

    User? firebaseUser= await AuthService.signUpUser(context, email, password);

    if(firebaseUser != null){
      PrefsService.saveUserId(firebaseUser.uid);
      Member member=Member(fullname, email);
      await DBService.storeMember(member);
      callHomePage(context);
    }else {
      UtilsService.fireToast("Please check your information!");
    }

    isLoading =false;
  }
}