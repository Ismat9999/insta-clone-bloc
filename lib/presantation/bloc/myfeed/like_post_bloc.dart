import 'package:bloc/bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/like_post_event.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/like_post_state.dart';

import '../../../data/datasources/remote/services/db_service.dart';

class LikePostBloc extends Bloc<LikedEvent, LikeState> {
  LikePostBloc() : super(LikePostInitialState()) {
    on<LikesPostEvent>(_onLikesPostEvent);
    on<UnLikesPostEvent>(_onUnLikesPostEvent);
  }

  Future<void> _onLikesPostEvent(LikesPostEvent event, Emitter<LikeState>emit) async {
    await DBService.likePost(event.post, true);
    event.post.liked = true;
    emit(LikePostSuccessState(post: event.post));
  }

  _onUnLikesPostEvent(UnLikesPostEvent event, Emitter<LikeState> emit) async {
    await DBService.likePost(event.post, false);
    event.post.liked = false;
    emit(UnLikePostSuccessState(post: event.post));
  }
}
