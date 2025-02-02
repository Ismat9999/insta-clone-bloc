import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_bloc.dart';

import '../../../data/models/post_model.dart';

Widget itemOfPost(Post post, MyFeedBloc feedBloc,BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Divider(),
        //   # user_info
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: post.img_user.isEmpty
                        ? Image(
                      image: AssetImage("assets/images/ic_person.png"),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      post.img_user,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.fullname,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        post.date,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
              post.mine
                  ? IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        //   #post image
        SizedBox(
          height: 8,
        ),
        CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          imageUrl: post.img_post,
          fit: BoxFit.cover,
        ),

        //   #like_share
        Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (!post.liked) {
                      feedBloc.apiLikePost(post);
                    } else {
                      feedBloc.apiUnlikePost(post);
                    }
                  },
                  icon: post.liked
                      ? Icon(
                    EvaIcons.heart,
                    color: Colors.red,
                  )
                      : Icon(
                    EvaIcons.heartOutline,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    EvaIcons.shareOutline,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        //   #caption
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Text(
            post.caption,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
