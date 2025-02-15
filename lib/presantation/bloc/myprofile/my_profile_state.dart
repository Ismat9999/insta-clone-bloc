import 'package:instaclonebloc/data/models/member_model.dart';

abstract class MyProfileState {}

class ProfileInitialState extends MyProfileState {}

class ProfileLoadingState extends MyProfileState {}

class ProfileLoadMemberState extends MyProfileState {
  Member member;

  ProfileLoadMemberState({required this.member});
}

class ProfileLFailureState extends MyProfileState {
  final String errorMessage;

  ProfileLFailureState(this.errorMessage);
}
