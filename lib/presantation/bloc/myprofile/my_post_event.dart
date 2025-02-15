import 'package:equatable/equatable.dart';
import 'package:instaclonebloc/data/models/post_model.dart';

abstract class MyPostEvent extends Equatable {
  const MyPostEvent();
}

class LoadMyPostEvent extends MyPostEvent {
  @override
  List<Object?> get props => [];
}

class RemoveMyPostEvent extends MyPostEvent {
  Post post;

  RemoveMyPostEvent({required this.post});

  @override
  List<Object?> get props => [];
}