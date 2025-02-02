import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_event.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_state.dart';

import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/post_model.dart';

class MyLikesBloc extends Bloc<MyLikesEvent, MyLikesState>{
  bool isLoading = false;
  List<Post> items = [];

  MyLikesBloc(): super(LikesInitialState());

  apiLoadLikes() async {
    isLoading = true;
    emit(LikesInitialState());

    var results = await DBService.loadLikes();
    items = results;
    isLoading = false;
    emit(LikesSuccsesState());
  }

  void apiUnlikePost(Post post) async {
    isLoading = true;
    emit(LikesInitialState());

    await DBService.likePost(post, false);

    apiLoadLikes();
  }
  apiRemovePost(Post post) async {
    isLoading= true;
    emit(LikesInitialState());

    await DBService.removePosts(post);

    apiLoadLikes();
  }

  void dialogRemovePost(BuildContext context, Post post)async{
    var result = await UtilsService.dialogCommon(context, "Remove", "Do you want to remove this post?", false);
    if(result){
      apiRemovePost(post);
    }
  }
}