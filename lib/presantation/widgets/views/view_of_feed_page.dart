import 'package:flutter/material.dart';
import 'package:instaclonebloc/data/models/post_model.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_bloc.dart';

import '../items/item_of_post.dart';

Widget viewOfFeedPage(BuildContext context, List<Post> items,
    MyFeedBloc feedBloc, bool isLoading) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        "Instagram",
        style: TextStyle(
            color: Colors.black, fontFamily: "Billabong", fontSize: 30),
      ),
      actions: [
        IconButton(
          onPressed: () {
            widget.pageController!.animateToPage(2,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          },
          icon: const Icon(
            Icons.camera_alt,
            color:const Color.fromRGBO(193, 53, 132, 1),
          ),
        ),
      ],
    ),
    body: Stack(
      children: [
        ListView.builder(
          itemCount: feedBloc.items.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(feedBloc.items[index], feedBloc, context);
          },
        ),
        feedBloc.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}
