import 'package:equatable/equatable.dart';
import 'package:instaclonebloc/data/models/post_model.dart';

abstract class LikedEvent extends Equatable {
  const LikedEvent();
}

class LikesPostEvent extends LikedEvent {
  Post post;

  LikesPostEvent({required this.post});

  @override
  List<Object?> get props => [];
}

class UnLikesPostEvent extends LikedEvent{
  Post post;

  UnLikesPostEvent({required this.post});

  @override
  List<Object?> get props => [];
}