import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_up/signup_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_up/signup_state.dart';

import '../widgets/views/view_of_sign_up_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpBloc signUpBloc;

  @override
  void initState() {
    super.initState();
    signUpBloc = context.read<SignUpBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccsesState) {
            signUpBloc.callHomePage(context);
          }
        },
        builder: (context, state) {
          if (state is SignUpLoadingState) {
            return viewOfSignUpPage(context, signUpBloc, true);
          }
          return viewOfSignUpPage(context, signUpBloc, false);
        },
      ),
    );
  }
}
