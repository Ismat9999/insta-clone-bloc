import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_state.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_bloc.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_upload_page.dart';

class MyUploadPage extends StatefulWidget {
  final PageController pageController;

  const MyUploadPage({super.key, required this.pageController});

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  late MyUploadBloc uploadBloc;
  late PickerBloc pickerBloc;
  PageController pageController= PageController();


  @override
  void initState() {
    super.initState();
    uploadBloc = context.read<MyUploadBloc>();
    pickerBloc = context.read<PickerBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyUploadBloc, MyUploadState>(
      listener: (context, state) {
        if (state is UploadSuccsesState) {
          uploadBloc.moveToFeedPage(pageController, pickerBloc);
        }
      },
      builder: (context, state) {
        if (state is UploadLoadingState) {
          return viewOfUploadPage(context, uploadBloc, pickerBloc, false);
        }
        return viewOfUploadPage(context, uploadBloc, pickerBloc, false);
      },
    );
  }
}
