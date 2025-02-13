import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_event.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_state.dart';


class PickerBloc extends Bloc<PickerEvent, PickerState>{
  var pickedImage = ImagePicker();
  File? image;

  PickerBloc(): super (PickInitilaState()){
    on<SelectedPhotoEvent>(_onSelectedPhotoEvent);
    on<ClearedPhotoEvent>(_onClearedPhotoEvent);
  }
  Future<void>_onSelectedPhotoEvent(SelectedPhotoEvent event, Emitter<PickerState> emit)async{
    image= event.image;
    emit(SelectedPhotoState());
}

Future<void>_onClearedPhotoEvent(ClearedPhotoEvent event, Emitter<PickerState> emit)async{
    image=null;
    emit(ClearedPhotoState());
}

  void imgFromGallery() async {
    XFile? image = await pickedImage.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    add(SelectedPhotoEvent(image: File(image!.path)));
  }

  void imgFromCamera() async {
    XFile? image = await pickedImage.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    add(SelectedPhotoEvent(image: File(image!.path)));
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick Photo'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take Photo'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

}