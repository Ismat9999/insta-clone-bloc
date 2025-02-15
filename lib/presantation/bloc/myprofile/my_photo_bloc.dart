import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclonebloc/core/services/file_service.dart';
import 'package:instaclonebloc/data/datasources/remote/services/db_service.dart';
import 'package:instaclonebloc/data/models/member_model.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_photo_state.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_photot_event.dart';

class MyPhotoBloc extends Bloc<MyPhotoEvent, MyPhotoState> {
  ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  MyPhotoBloc() : super(MyPhotoInitialState()) {
    on<UploadMyPhotoEvent>(_onUploadMyPhotoEvent);
  }

  Future<void>_onUploadMyPhotoEvent(UploadMyPhotoEvent event, Emitter<MyPhotoState> emit)async{
    emit(MyPhotoLoadingState());
    var downloadUrl= await FileService.uploadUserImage(event.image);
    Member member= await DBService.loadMember();
    member.img_url=downloadUrl;
    await DBService.updateMember(member);
    emit(MyPhotoSuccessState());
  }
  _pickFromGallery() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    add(UploadMyPhotoEvent(image: File(image!.path)));
  }

  _pickFromCamera() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    add(UploadMyPhotoEvent(image: File(image!.path)));
  }

  showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Pick  Photo"),
                onTap: () {
                  _pickFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Take  Photo"),
                onTap: () {
                  _pickFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ]),
          );
        });
  }
}
