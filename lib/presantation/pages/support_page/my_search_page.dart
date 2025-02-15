import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_event.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_state.dart';
import 'package:instaclonebloc/presantation/widgets/views/view_of_search_page.dart';

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
    searchBloc.add(LoadSearchMemberEvent(keyword: ""));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MySearchBloc, MySearchState>(
      listener: (context, state){},
      builder: (context, state){
        if(state is SearchsLoadingState){
          return viewOfSearchPage(context,searchBloc,true,[]);
        }
        if(state is SearchsSuccsesState){
          return viewOfSearchPage(context, searchBloc,false, state.items);
        }
        return viewOfSearchPage(context, searchBloc,true,[]);
      },
    );
  }
}

