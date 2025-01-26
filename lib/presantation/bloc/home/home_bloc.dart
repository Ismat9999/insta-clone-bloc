
import 'package:bloc/bloc.dart';
import 'package:instaclonebloc/presantation/bloc/home/home_state.dart';

import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  int currentTap= 0;

  HomeBloc(): super(CurrentIndexState(currentIndex: 0));

  void onBottomChange(int index) {
    emit(CurrentIndexState(currentIndex: index));
  }

  void onPageViewChange(int index) {
    emit(CurrentIndexState(currentIndex: index));
  }
}