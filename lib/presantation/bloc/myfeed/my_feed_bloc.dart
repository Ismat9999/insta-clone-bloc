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

  MyFeedBloc() : super(FeedInitialState()) {
    on<LoadFeedPostsEvent>(_onLoadFeedPostsEvent);
    on<RemoveFeedPostsEvent>(_onRemoveFeedPostsEvent);
  }

  Future<void> _onLoadFeedPostsEvent(
      LoadFeedPostsEvent event, Emitter<MyFeedState> emit) async {
    emit(FeedLoadingState());
    var posts = await DBService.loadFeeds();
    items.clear();
    items.addAll(posts);
    if (posts.isNotEmpty) {
      emit(FeedSuccsesState(items: items));
    } else {
      emit(FeedFailureState("No data"));
    }
  }

  Future<void> _onRemoveFeedPostsEvent(RemoveFeedPostsEvent event, Emitter<MyFeedState> emit) async {
    emit(FeedLoadingState());
    await DBService.removePosts(event.post);
    emit(RemoveFeedPostsState());
  }

  void dialogRemovePost(BuildContext context, Post post) async {
    var result = await UtilsService.dialogCommon(
        context, "Remove", "Do you want to remove this post?", false);
    if (result) {
      add(LoadFeedPostsEvent());
    }
  }
}
