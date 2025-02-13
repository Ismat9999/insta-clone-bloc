import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_event.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_state.dart';

Widget viewOfUploadPage(BuildContext context, MyUploadBloc uploadBloc,
    PickerBloc pickerBloc, bool isLoading) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("Upload"),
      actions: [
        IconButton(
          onPressed: () {
            uploadBloc.uploadNewPost(pickerBloc);
          },
          icon: Icon(
            Icons.drive_folder_upload,
            color: Color.fromRGBO(193, 53, 132, 1),
          ),
        ),
      ],
    ),
    body: Stack(
        children: [
      SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            GestureDetector(
              onTap: () {
                pickerBloc.showPicker(context);
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width,
                color: Colors.grey.withOpacity(0.4),
                child: BlocConsumer<PickerBloc, PickerState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is SelectedPhotoState) {
                        return Stack(
                          children: [
                            Image.file(
                              pickerBloc.image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.black12,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      pickerBloc.add(ClearedPhotoEvent());
                                    },
                                    icon: Icon(
                                      Icons.highlight_remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.white,
                        ),
                      );
                    }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextField(
                controller: uploadBloc.captionController,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Caption",
                  hintStyle: TextStyle(fontSize: 17, color: Colors.black38),
                ),
              ),
            ),
          ]),
        ),
      ),
          uploadBloc.isLoading
              ?  Center(
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
    ]
    ),
  );
}
