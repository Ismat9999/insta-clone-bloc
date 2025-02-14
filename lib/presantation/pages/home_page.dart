import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_state.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/like_post_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myfeed/my_feed_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mylikes/my_likes_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/my_upload_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myupload/picker_bloc.dart';
import 'package:instaclonebloc/presantation/pages/support_page/my_feed_page.dart';
import 'package:instaclonebloc/presantation/pages/support_page/my_likes_page.dart';
import 'package:instaclonebloc/presantation/pages/support_page/my_profile_page.dart';
import 'package:instaclonebloc/presantation/pages/support_page/my_search_page.dart';
import 'package:instaclonebloc/presantation/pages/support_page/my_upload_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            onPageChanged: (index) {
              homeBloc.onPageViewChange(index);
            },
            controller: pageController,
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyFeedBloc(),
                  ),
                  BlocProvider(
                    create: (context) => LikePostBloc(),
                  ),
                ],
                child: MyFeedPage(pageController: pageController,),
              ),
              BlocProvider(
                create: (context) => MySearchBloc(),
                child: MySearchPage(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyUploadBloc(),
                  ),
                  BlocProvider(
                    create: (context) => PickerBloc(),
                  ),
                ],
                child: MyUploadPage(pageController: pageController),
              ),
              BlocProvider(
                create: (context) => MyLikesBloc(),
                child: MyLikesPage(),
              ),
              BlocProvider(
                create: (context) => MyProfileBloc(),
                child: MyProfilePage(),
              ),
            ],
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (index) {
              homeBloc.onBottomChange(index);
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            currentIndex: homeBloc.currentTap,
            activeColor: Color.fromRGBO(193, 53, 132, 1),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
