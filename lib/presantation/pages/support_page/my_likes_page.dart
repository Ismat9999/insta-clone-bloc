import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_state.dart';

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
    likesBloc=context.read<MyLikesBloc>();
    likesBloc.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Likes"),
      ),
      body: BlocBuilder<MyLikesBloc, MyLikesState>(
        builder: (context, state) {
          return Stack(children: [
            ListView.builder(
              itemCount: likesBloc.items.length,
              itemBuilder: (ctx, index) {
                return itemOfLikes(likesBloc.items[index],likesBloc ,context);
              },
            ),
            likesBloc.isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SizedBox.shrink(),
          ]);
        },
      ),
    );
  }
}
