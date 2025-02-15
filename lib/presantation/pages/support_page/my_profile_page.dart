import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_photo_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_event.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_state.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_state.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_profile_page.dart';

import '../../../data/models/member_model.dart';
import '../../bloc/myprofile/my_profile_event.dart';
import '../../widgets/items/item_of_profile.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late MyProfileBloc profileBloc;
  late MyPostBloc postBloc;
  late MyPhotoBloc photoBloc;


  @override
  void initState() {
    super.initState();
    profileBloc=context.read<MyProfileBloc>();
    profileBloc.add(LoadProfileMemberEvent());

    postBloc= context.read<MyPostBloc>();
    postBloc.add(LoadMyPostEvent());

    postBloc.stream.listen((state){
      if(state is RemoveMyPostEvent){
        postBloc.add(LoadMyPostEvent());
      }
    });

    photoBloc= context.read<MyPhotoBloc>();
    photoBloc.stream.listen((state){
      if(state is MyPostSuccessState){
        profileBloc.add(LoadProfileMemberEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyProfileBloc, MyProfileState>(
      listener: (context, state){},
      builder: (context, state){
        if(state is ProfileLoadingState){
          return viewOfProfilePage(context,profileBloc,photoBloc,true,Member("", ""));
        }
        if(state is ProfileLoadMemberState){
          return viewOfProfilePage(context,profileBloc,photoBloc,false, state.member);
        }
        return viewOfProfilePage(context,profileBloc,photoBloc,false, Member("", ""));
      },
    );
  }
}

