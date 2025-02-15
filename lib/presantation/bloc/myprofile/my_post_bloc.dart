import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:instaclonebloc/core/services/utils_service.dart';
import 'package:instaclonebloc/data/datasources/remote/services/db_service.dart';
import 'package:instaclonebloc/data/models/post_model.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_event.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_state.dart';

class MyPostBloc extends Bloc<MyPostEvent, MyPostState> {
  MyPostBloc() : super(MyPostInitialState()) {
    on<LoadMyPostEvent>(_onLoadMyPostEvent);
    on<RemoveMyPostEvent>(_onRemoveMyPostEvent);
  }

  Future<void> _onLoadMyPostEvent(
      LoadMyPostEvent event, Emitter<MyPostState> emit) async {
    emit(MyPostLoadingState());
    var items = await DBService.loadPosts();
    if (items.isNotEmpty) {
      emit(MyPostSuccessState(items: items));
    } else {
      emit(MyPostFailureState("No posts"));
    }
  }

  Future<void> _onRemoveMyPostEvent(
      RemoveMyPostEvent event, Emitter<MyPostState> emit) async {
    emit(MyPostLoadingState());
    await DBService.removePosts(event.post);
    emit(RemoveMyPostState());
  }

  dialogRemovePost(Post post, BuildContext context) async {
    var result = await UtilsService.dialogCommon(
        context, 'Instagram', 'Do you want to delete this post?', false);
    if (result) {
      add(RemoveMyPostEvent(post: post));
    }
  }
}
