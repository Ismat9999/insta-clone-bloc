import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/sign_in/signin_state.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_sign_in_page.dart';

import '../bloc/sign_in/signin_event.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInBloc signInBloc;




  @override
  void initState() {
    super.initState();
    signInBloc = context.read<SignInBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccsesState) {
            signInBloc.callHomePage(context);
          }
        },
        builder: (context, state) {
          if (state is SignInLoadingState) {
            return viewOfSignInPage(context, signInBloc,true);
          }
          return viewOfSignInPage(context, signInBloc,false);
        },
      ),
    );
  }
}
