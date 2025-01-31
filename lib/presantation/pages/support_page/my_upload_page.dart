import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_state.dart';

class MyUploadPage extends StatefulWidget {
  final PageController pageController;
  const MyUploadPage({super.key, required this.pageController});

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  late MyUploadBloc uploadBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Upload"),
        actions: [
          IconButton(
            onPressed: (){
              uploadBloc.uploadNewPost(widget.pageController);
            },
            icon: Icon(Icons.drive_folder_upload, color: Color.fromRGBO(193, 53, 132, 1),),
          ),
        ],
      ),
      body: BlocBuilder<MyUploadBloc, MyUploadState>(
        builder: (context, state){
          return Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          uploadBloc.imgFromGallery();
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width,
                          color: Colors.grey.withOpacity(0.4),
                          child: uploadBloc.pickedImage == null
                              ? Center(
                            child: Icon(Icons.add_a_photo,size: 50,color: Colors.grey,),
                          ): Stack(
                            children: [
                              Image.file(
                                uploadBloc.pickedImage!,
                                width: double.infinity,
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
                                      onPressed: (){
                                        uploadBloc.removePickedImage();
                                      },
                                      icon: Icon(Icons.highlight_remove,color: Colors.white,size: 30,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                            hintText:"Caption",
                            hintStyle: TextStyle(fontSize: 17, color: Colors.black38),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              uploadBloc.isLoading ? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}