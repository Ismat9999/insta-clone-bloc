import 'package:instaclonebloc/data/models/post_model.dart';

abstract class MyLikesEvent {}

class LoadLikesPostEvent extends MyLikesEvent {
  @override
  List<Object?> get props => [];
}

class UnLikePostEvent extends MyLikesEvent {
  Post post;

  UnLikePostEvent({required this.post});

  @override
  List<Object?> get props => [];
}

class RemovePostEvent extends MyLikesEvent {
  Post post;

  RemovePostEvent({required this.post});

  @override
  List<Object?> get props => [];
}
