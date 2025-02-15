import 'package:equatable/equatable.dart';
import 'package:instaclonebloc/data/models/member_model.dart';

abstract class FollowEvent extends Equatable{
  const FollowEvent();
}
class FollowMemberEvent extends FollowEvent{
  Member someone;

  FollowMemberEvent({required this.someone});
  @override
  List<Object?> get props => [];
}
class UnFollowMemberEvent extends FollowEvent{
  Member someone;

  UnFollowMemberEvent({required this.someone});

  @override
  List<Object?> get props => [];
}