import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/follow_event.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/follow_state.dart';

import '../../../data/datasources/remote/services/db_service.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(FollowMemberInitialState()) {
    on<FollowMemberEvent>(_onFollowMemberEvent);
    on<UnFollowMemberEvent>(_onUnFollowMemberEvent);
  }

  Future<void> _onFollowMemberEvent(FollowMemberEvent event, Emitter<FollowState> emit) async {

    await DBService.followMember(event.someone);
    event.someone.followed = true;
    emit(FollowMemberSuccessState(member: event.someone));

    // Store someone's posts to my feed
    await DBService.storePostsToMyFeed(event.someone);
  }
  Future<void> _onUnFollowMemberEvent(UnFollowMemberEvent event, Emitter<FollowState> emit) async {

    await DBService.followMember(event.someone);
    event.someone.followed = false;
    emit(UnFollowMemberSuccessState(member: event.someone));

    // Remove someone's posts to my feed
    DBService.removePostsToMyFeed(event.someone);
  }
}
