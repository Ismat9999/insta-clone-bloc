import 'package:instaclonebloc/data/models/post_model.dart';

abstract class MyLikesState {}

class LikesInitialState extends MyLikesState {}

class LikesLoadingState extends MyLikesState {}

class LikesSuccsesState extends MyLikesState {
  List<Post> items;

  LikesSuccsesState({required this.items});
}

class LikesFailureState extends MyLikesState {
  final String errorMessage;

  LikesFailureState(this.errorMessage);
}

class UnLikePostSuccessState extends MyLikesState {}

class RemovePostSuccessState extends MyLikesState {}
