import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_event.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_state.dart';

import '../../../core/services/file_service.dart';
import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/post_model.dart';

class MyUploadBloc extends Bloc<MyUploadEvent, MyUploadState> {
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? pickedImage;

  MyUploadBloc() : super(UploadInitialState());

  uploadNewPost(PageController pageController) async{
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (pickedImage == null) return;

    isLoading = true;

    String img_post = await FileService.uploadPostImage(pickedImage!);
    Post post = Post(caption, img_post);
    Post mypost= await DBService.storePost(post);
    await DBService.storeFeed(mypost);

    isLoading = false;

    clearImageAndCaption(pageController);
  }

  clearImageAndCaption(PageController pageController) {
    captionController.text = "";
    removePickedImage();
    moveToFeedPage(pageController);
  }

  moveToFeedPage(PageController pageController) {
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void imgFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      pickedImage = File(image.path);
    }
    emit(UploadSuccsesState());
  }

  void imgFromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    pickedImage = File(image!.path);
    emit(UploadSuccsesState());
  }

  removePickedImage() {
    pickedImage = null;
    emit(UploadSuccsesState());
  }
}
