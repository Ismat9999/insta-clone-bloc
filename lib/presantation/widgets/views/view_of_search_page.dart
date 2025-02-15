import 'package:flutter/material.dart';
import 'package:instaclonebloc/data/models/member_model.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_bloc.dart';

import '../items/item_of_member.dart';

Widget viewOfSearchPage(BuildContext context, MySearchBloc searchBloc, bool isLoading, List<Member> items){
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      title: Text("Search"),
    ),
    body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  //   #search member
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextField(
                      style: TextStyle(color: Colors.black87),
                      controller: searchBloc.searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle:
                        TextStyle(fontSize: 15, color: Colors.grey),
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  //   #member_list
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index){
                        return itemOfMember(items[index],searchBloc,context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            searchBloc.isLoading ? Center(
              child: CircularProgressIndicator(),
            ): SizedBox.shrink(),
          ],
        ),
    );
}