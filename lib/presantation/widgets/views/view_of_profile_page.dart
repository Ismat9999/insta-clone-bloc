import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/data/models/member_model.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/axis_count_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_photo_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_post_state.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_bloc.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_my_posts.dart';

Widget viewOfProfilePage(BuildContext context, MyProfileBloc profileBloc,
    MyPhotoBloc photoBloc, bool isLoading, Member member) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("Profile"),
      actions: [
        IconButton(
          onPressed: () {
            profileBloc.dialogLogout(context);
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Color.fromRGBO(192, 53, 132, 1),
          ),
        ),
      ],
    ),
    body: Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //# myphoto
              GestureDetector(
                // #myphoto
                onTap: () {
                  photoBloc.showPicker(context);
                },
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(
                          width: 1.5,
                          color: Color.fromRGBO(193, 53, 132, 1),
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: member.img_url.isEmpty
                              ? Image(
                                  image:
                                      AssetImage("assets/images/ic_person.png"),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  member.img_url,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //   #myinfo
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    member.fullname.toUpperCase(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(member.email,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              //   #myaccount
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            BlocBuilder<MyPostBloc, MyPostState>(
                              builder: (context, state) {
                                if (state is MyPostSuccessState) {
                                  return Text(
                                    state.items.length.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                                return const Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "POST",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              member.following_count.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "FOLLOWERS",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              member.followers_count.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "FOLLOWING",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //   #list_or_grid
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<AxisCountBloc>()
                                .add(AxisCountEvent(axisCount: 1));
                          },
                          icon: Icon(Icons.list_alt),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<AxisCountBloc>()
                                .add(AxisCountEvent(axisCount: 2));
                          },
                          icon: Icon(Icons.grid_view),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // myposts
              BlocConsumer<MyPostBloc, MyPostState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is MyPostSuccessState) {
                    return viewOfMyPosts(state.items);
                  }
                  return viewOfMyPosts([]);
                },
              ),
            ],
          ),
        ),
        photoBloc.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}
