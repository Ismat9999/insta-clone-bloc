import 'package:instaclonebloc/data/models/post_model.dart';

abstract class MyPostState {}

class MyPostInitialState extends MyPostState {}

class MyPostLoadingState extends MyPostState {}

class MyPostSuccessState extends MyPostState {
  List<Post> items;

  MyPostSuccessState({required this.items});
}

class MyPostFailureState extends MyPostState {
  final String errorMessage;

  MyPostFailureState(this.errorMessage);
}

class RemoveMyPostState extends MyPostState {}
