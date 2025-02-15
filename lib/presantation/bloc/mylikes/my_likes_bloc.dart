import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_event.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_state.dart';

import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/post_model.dart';

class MyLikesBloc extends Bloc<MyLikesEvent, MyLikesState> {
  bool isLoading = false;

  MyLikesBloc() : super(LikesInitialState()) {
    on<LoadLikesPostEvent>(_onLoadLikesPostEvent);
    on<UnLikePostEvent>(_onUnLikePostEvent);
    on<RemovePostEvent>(_onRemovePostEvent);
  }

  Future<void> _onLoadLikesPostEvent(
      LoadLikesPostEvent event, Emitter<MyLikesState> emit) async {
    emit(LikesLoadingState());
    var items = await DBService.loadLikes();
    if (items.isNotEmpty) {
      emit(LikesSuccsesState(items: items));
    } else {
      emit(LikesFailureState("No data"));
    }
  }

  Future<void> _onUnLikePostEvent(
      UnLikePostEvent event, Emitter<MyLikesState> emit) async {
    emit(LikesLoadingState());
    await DBService.likePost(event.post, false);
    emit(UnLikePostSuccessState());
  }

  _onRemovePostEvent(RemovePostEvent event, Emitter<MyLikesState> emit) async {
    emit(LikesLoadingState());
    await DBService.removePosts(event.post);
    emit(RemovePostSuccessState());
  }

  void dialogRemovePost(BuildContext context, Post post) async {
    var result = await UtilsService.dialogCommon(
        context, "Remove", "Do you want to remove this post?", false);
    add(LoadLikesPostEvent());
    if (result) {
      add(RemovePostEvent(post: post));
    }
  }
}
