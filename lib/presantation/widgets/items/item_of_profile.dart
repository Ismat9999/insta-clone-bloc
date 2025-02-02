import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';

Widget itemOfProfile(Post post, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(5),
    child: Column(
      children: [
        Expanded(
          child: CachedNetworkImage(
            width: double.infinity,
            imageUrl: post.img_post,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          post.caption,
          style: TextStyle(
            color: Colors.black87.withOpacity(0.7),
          ),
          maxLines: 2,
        ),
      ],
    ),
  );
}
