import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_event.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_state.dart';

import '../../../core/services/utils_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/post_model.dart';

class MyFeedBloc extends Bloc<MyFeedEvent, MyFeedState> {
  bool isLoading = false;
  List<Post> items = [];

  MyFeedBloc() : super(FeedInitialState());

  apiLoadMyFeed() async {
    isLoading = true;
    emit(FeedLoadingState());

    var results = await DBService.loadFeeds();
    items = results;
    isLoading = false;

  }

  apiLikePost(Post post) async {
    isLoading = true;
    emit(FeedLoadingState());

    await DBService.likePost(post, true);
    post.liked = true;
    isLoading = false;

  }

  apiUnlikePost(Post post) async {
    isLoading = true;
    emit(FeedLoadingState());

    await DBService.likePost(post, false);

    post.liked = false;
    isLoading = false;

  }

  apiRemovePost(Post post) async {
    isLoading = true;


    await DBService.removePosts(post);

    apiLoadMyFeed();
  }

  void dialogRemovePost(BuildContext context, Post post) async {
    var result = await UtilsService.dialogCommon(
        context, "Remove", "Do you want to remove this post?", false);
    if (result) {
      apiRemovePost(post);
    }
  }
}
