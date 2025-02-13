import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_event.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_state.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_event.dart';

import '../../../core/services/file_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/post_model.dart';

class MyUploadBloc extends Bloc<UploadPostsEvent, MyUploadState> {
  bool isLoading = false;
  var captionController = TextEditingController();


  MyUploadBloc() : super(UploadInitialState()) {
    on<UploadPostsEvent>(_onUploadPostsEvent);
  }

  Future<void> _onUploadPostsEvent(
      UploadPostsEvent event, Emitter<MyUploadState> emit) async {
    var downloadUrl = await FileService.uploadPostImage(event.image);
    if (downloadUrl.isEmpty) {
      emit(UploadFailureState("Please try again later"));
    }
    Post post = Post(event.caption, downloadUrl);
    // Post to posts
    Post mypost = await DBService.storePost(post);
    await DBService.storeFeed(mypost);
    emit(UploadSuccsesState());
  }

  moveToFeedPage(PageController pageController,PickerBloc pickerBloc) {
    captionController.text = "";
    pickerBloc.add(ClearedPhotoEvent());
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  uploadNewPost(PickerBloc pickerBloc) {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (pickerBloc.image == null) return;
    add(UploadPostsEvent(caption: caption, image: pickerBloc.image!));
  }
}
