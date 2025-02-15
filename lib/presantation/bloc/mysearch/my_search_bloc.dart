import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_event.dart';
import 'package:instaclonebloc/presantation/bloc/mysearch/my_search_state.dart';

import '../../../data/datasources/remote/services/db_service.dart';
import '../../../data/models/member_model.dart';

class MySearchBloc extends Bloc<MySearchEvent, MySearchState> {
  bool isLoading = false;
  var searchController=TextEditingController();

  MySearchBloc() : super(SearchsInitialState()) {
    on<LoadSearchMemberEvent>(_onLoadSearchMemberEvent);
  }

  Future<void> _onLoadSearchMemberEvent(
      LoadSearchMemberEvent event, Emitter<MySearchState> emit) async {
    emit(SearchsLoadingState());
    var items = await DBService.searchMembers(event.keyword);
    if (items.isNotEmpty) {
      emit(SearchsSuccsesState(items: items));
    } else {
      emit(SearchsFailureState("No Member"));
    }
  }
}
