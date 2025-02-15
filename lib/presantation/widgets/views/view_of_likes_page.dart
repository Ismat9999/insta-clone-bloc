import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_bloc.dart';

import '../../../data/models/post_model.dart';
import '../items/item_of_likes.dart';

Widget viewOfLikesPage(BuildContext context, MyLikesBloc likesBloc,
    bool isLoading, List<Post> items) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Likes"),
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return itemOfLikes(items[index], likesBloc, context);
          },
        ),
        likesBloc.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink(),
      ]));
}
