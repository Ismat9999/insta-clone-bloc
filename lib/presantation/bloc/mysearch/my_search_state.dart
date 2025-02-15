import 'package:instaclonebloc/data/models/member_model.dart';

abstract class MySearchState {}

class SearchsInitialState extends MySearchState {}

class SearchsLoadingState extends MySearchState {}

class SearchsSuccsesState extends MySearchState {
  List<Member> items;

  SearchsSuccsesState({required this.items});
}

class SearchsFailureState extends MySearchState {
  final String errorMessage;

  SearchsFailureState(this.errorMessage);
}
