import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_event.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_state.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_feed_page.dart';

import '../../widgets/items/item_of_post.dart';

class MyFeedPage extends StatefulWidget {
  final PageController pageController;

  const MyFeedPage({super.key, required this.pageController});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  late MyFeedBloc feedBloc;

  @override
  void initState() {
    super.initState();
    feedBloc = (context).read<MyFeedBloc>();
    feedBloc.add(LoadFeedPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyFeedBloc, MyFeedState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FeedLoadingState) {
          return viewOfFeedPage(context, feedBloc.items, feedBloc, false,widget);
        }
        if (state is FeedSuccsesState) {
          return viewOfFeedPage(context, feedBloc.items, feedBloc, false,widget);
        }
        return viewOfFeedPage(context, feedBloc.items, feedBloc, true,widget);
      },
    );
  }
}
