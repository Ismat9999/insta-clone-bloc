import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_state.dart';

import '../../widgets/items/item_of_member.dart';


class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  late MySearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc= context.read<MySearchBloc>();
    searchBloc.apiLoadMembers("");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Search"),
      ),
      body: BlocBuilder<MySearchBloc, MySearchState>(
        builder: (context, state) {
          return Stack(
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
                        itemCount: searchBloc.items.length,
                        itemBuilder: (context, index){
                          return itemOfMember(searchBloc.items[index],searchBloc,context);
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
          );
        },
      ),
    );
  }
}

