import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/main.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_state.dart';

import '../../bloc/myfeed/my_feed_event.dart';
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
    feedBloc= (context).read<MyFeedBloc>();
    feedBloc.apiLoadMyFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Instagram",
          style: TextStyle(
              color: Colors.black, fontFamily: "Billabong", fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.pageController.animateToPage(2,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            icon: Icon(
              Icons.camera_alt,
              color: Color.fromRGBO(193, 53, 132, 1),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyFeedBloc, MyFeedState>(
        builder: (context, state) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: feedBloc.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(feedBloc.items[index],feedBloc,context);
                },
              ),
              feedBloc.isLoading ? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}

