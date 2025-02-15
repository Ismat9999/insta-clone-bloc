import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/data/models/post_model.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/axis_count_bloc.dart';

import '../items/item_of_profile.dart';

Widget viewOfMyPosts(List<Post> items) {
  return Expanded(
    child: BlocBuilder<AxisCountBloc, int>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: state,
          ),
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return itemOfProfile(items[index], context);
          },
        );
      },
    ),
  );
}
