import 'package:equatable/equatable.dart';
import 'package:instaclonebloc/data/models/post_model.dart';

abstract class MyFeedEvent extends Equatable {
  const MyFeedEvent();
}

class LoadFeedPostsEvent extends MyFeedEvent {
  @override
  List<Object?> get props => [];
}

class RemoveFeedPostsEvent extends MyFeedEvent {
  Post post;

  RemoveFeedPostsEvent({required this.post});

  @override
  List<Object?> get props => [];
}
