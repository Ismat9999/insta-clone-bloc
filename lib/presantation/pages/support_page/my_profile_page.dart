import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/myprofile/my_profile_state.dart';

import '../../widgets/items/item_of_profile.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late MyProfileBloc profileBloc;


  @override
  void initState() {
    super.initState();
    profileBloc=context.read<MyProfileBloc>();
    profileBloc.apiLoadMember();
    profileBloc.apiLoadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              profileBloc.doSignOut(context);
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Color.fromRGBO(192, 53, 132, 1),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyProfileBloc, MyProfileState>(
        builder: (context, state) {
          return Column(
            children: [
              //# myphoto
              GestureDetector(
                // #myphoto
                onTap: () {
                  profileBloc.pickFromGallery();
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
                          child: profileBloc.member_image == null ||
                              profileBloc.member_image!.isEmpty
                              ? Image(
                            image:
                            AssetImage("assets/images/ic_person.png"),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            profileBloc.member_image!,
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
                    profileBloc.member_fullname!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(profileBloc.member_email!,
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
                            Text(
                              profileBloc.count_posts.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
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
                              profileBloc.count_follower.toString(),
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
                              profileBloc.count_following.toString(),
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
                            profileBloc.changedAxisCount(1);
                          },
                          icon: Icon(Icons.list_alt),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            profileBloc.changedAxisCount(2);
                          },
                          icon: Icon(Icons.grid_view),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // myposts
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: profileBloc.axisCount),
                  itemCount: profileBloc.items.length,
                  itemBuilder: (context, index) {
                    return itemOfProfile(
                        profileBloc.items[index], context);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

