import '../../../data/models/post_model.dart';

abstract class MyFeedState {}

class FeedInitialState extends MyFeedState {}

class FeedLoadingState extends MyFeedState {}

class FeedSuccsesState extends MyFeedState {
  List<Post> items;

  FeedSuccsesState({required this.items});
}

class FeedFailureState extends MyFeedState {
   final String errorMessage;

  FeedFailureState(this.errorMessage);
}

class RemoveFeedPostsState extends MyFeedState {
  RemoveFeedPostsState();
}
