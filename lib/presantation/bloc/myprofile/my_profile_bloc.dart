import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_photot_event.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_event.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_state.dart';
import 'package:instaclonebloc/presantation/pages/sign_in_page.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../sign_in/signin_bloc.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {


  MyProfileBloc() : super(ProfileInitialState()) {
    on<LoadProfileMemberEvent>(_onProfileInfoEvent);
  }

  Future<void> _onProfileInfoEvent(
      LoadProfileMemberEvent event, Emitter<MyProfileState> emit) async {
    emit(ProfileLoadingState());
    var member = await DBService.loadMember();
    emit(ProfileLoadMemberState(member: member));
  }

  void dialogLogout(BuildContext context) async {
    var result = await UtilsService.dialogCommon(
        context, 'Instagram', "Do you want to logout?", false);
    if (result) {
      _doSignOut(context);
    }
  }

  _doSignOut(BuildContext context) async {
    await AuthService.signOutUser();
    callSignInPage(context);
  }

  callSignInPage(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => SignInBloc(),
        child: SignInPage(),
      );
    }));
  }
}
