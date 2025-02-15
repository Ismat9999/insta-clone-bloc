import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_event.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_state.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_likes_page.dart';

import '../../widgets/items/item_of_likes.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({super.key});

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  late MyLikesBloc likesBloc;

  @override
  void initState() {
    super.initState();
    likesBloc = context.read<MyLikesBloc>();
    likesBloc.add(LoadLikesPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyLikesBloc,MyLikesState>(
      listener: (context, state) {
        if (state is UnLikePostSuccessState) {
          likesBloc.add(LoadLikesPostEvent());
        }
      },
      builder: (context, state) {
        if (state is LikesLoadingState) {
          return viewOfLikesPage(context,likesBloc,true, []);
        }
        if (state is LikesSuccsesState) {
          return viewOfLikesPage(context, likesBloc,false,state.items);
        }
        return viewOfLikesPage(context,likesBloc,false, []);
      },
    );
  }
}
