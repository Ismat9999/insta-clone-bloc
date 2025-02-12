import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();
  var cpasswordController = TextEditingController();

  bool isLoading = false;

  SignUpBloc() : super(SignUpInitialState()) {
    on<SignedUpEvent>(_onSignedUpEvent);
  }

  Future<void> _onSignedUpEvent(
      SignedUpEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    User? firebaseUser = await AuthService.signUpUser(
        event.context, event.email, event.password);

    if (firebaseUser != null) {
      _saveMemberIdToLocal(firebaseUser);
      _saveMemberToCloud(Member(event.fullname, event.email));
      emit(SignUpSuccsesState());
    } else {
      emit(SignUpFailureState("Please check your information!"));
    }
  }

  _saveMemberIdToLocal(User firebaseUser) async {
    await PrefsService.saveUserId(firebaseUser.uid);
  }

  _saveMemberToCloud(Member member) async {
    await DBService.storeMember(member);
  }

  void callHomePage(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => HomeBloc(),
        child: HomePage(),
      );
    }));
  }

  void callSignInPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInBloc(),
            child: SignInPage(),
          ),
        ));
  }

  void doSignUp(BuildContext context) async {
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        cpassword.isEmpty) {
      UtilsService.fireToast("Please fill out your information!");
      return;
    }

    if (password != cpassword) {
      UtilsService.fireToast("Your password did not match!");
      return;
    }
    add(SignedUpEvent(context: context, fullname: fullname, email: email, password: password));
  }
}
