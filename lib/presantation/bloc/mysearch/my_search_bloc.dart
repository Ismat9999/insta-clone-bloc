import 'package:bloc/bloc.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_event.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_state.dart';

import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/member_model.dart';

class MySearchBloc extends Bloc<MySearchEvent, MySearchState>{
  bool isLoading = false;
  List<Member> items = [];

  MySearchBloc(): super(SearchsInitialState());

  apiLoadMembers(String keyword)async{
    isLoading=true;
    emit(SearchsLoadingState());

    var results=await DBService.searchMembers(keyword);
    items = results;
    isLoading= false;
    emit(SearchsSuccsesState());
  }

  void followMember(Member someone)async{
    isLoading=true;
    emit(SearchsLoadingState());

    await DBService.followMember(someone);
    someone.followed=true;

    isLoading=false;
    emit(SearchsSuccsesState());

    // Store someone's posts to my feed
    await DBService.storePostsToMyFeed(someone);
  }

  void unFollowMember(Member someone)async{
    isLoading=true;
    emit(SearchsLoadingState());

    await DBService.unFollowMember(someone);
    someone.followed=false;

    isLoading=false;
    emit(SearchsSuccsesState());

    // Remove someone's posts to my feed
    DBService.removePostsToMyFeed(someone);
  }
}