import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_event.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_state.dart';
import 'package:instaclonebloc/presantation/pages/sign_in_page.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/file_service.dart';
import '../../../core/services/log_service.dart';
import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/local/prefs_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/member_model.dart';
import '../../../data/models/post_model.dart';
import '../sign_in/signin_bloc.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  String? member_image;
  String? member_fullname = "Ismatilla";
  String? member_email = "ismatilla@gmail.com";

  ImagePicker picker = ImagePicker();

  int count_posts = 0;
  int count_following = 0;
  int count_follower = 0;

  int axisCount = 2;

  List<Post> items = [];

  MyProfileBloc() : super(ProfileInitialState());

  apiLoadPosts() async {
    var results = await DBService.loadPosts();
    items = results;
    count_posts = items.length;
    emit(ProfileSuccsesState());
  }

  apiLoadMember() async {
    Member member = await DBService.loadMember();

    member_fullname = member.fullname;
    member_email = member.email;
    member_image = member.img_url;
    count_follower = member.followers_count;
    count_following= member.following_count;
    emit(ProfileSuccsesState());
  }

  void changedAxisCount(int axisCount) {
    this.axisCount = axisCount;
    emit(ProfileSuccsesState());
  }

  void doSignOut(BuildContext context) async {
    var result = await UtilsService.dialogCommon(
        context, "Sign Out", "Do you want to sign out!", false);
    LogService.i(result.toString());
    if (result) {
      await AuthService.signOutUser();
      PrefsService.removeUserId();
      callSignInPage(context);
    }
  }

  pickFromGallery() async {
    XFile? image =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(image != null){
      var pickedImage= File(image.path);

      String downloadUrl = await FileService.uploadUserImage(pickedImage);
      Member member =await DBService.loadMember();
      member.img_url=downloadUrl;
      await DBService.updateMember(member);
      apiLoadMember();
    }
  }
  callSignInPage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => SignInBloc(),
        child: SignInPage(),
      );
    }));
  }
}
