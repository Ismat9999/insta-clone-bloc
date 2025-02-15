import 'package:equatable/equatable.dart';
import 'package:instaclonebloc/data/models/member_model.dart';

abstract class FollowState extends Equatable {}

class FollowMemberInitialState extends FollowState {
  @override
  List<Object?> get props => [];
}

class FollowMemberSuccessState extends FollowState {
  Member member;

  FollowMemberSuccessState({required this.member});

  @override
  List<Object?> get props => [];
}

class UnFollowMemberSuccessState extends FollowState {
  Member member;

  UnFollowMemberSuccessState({required this.member});

  @override
  List<Object?> get props => [];
}
