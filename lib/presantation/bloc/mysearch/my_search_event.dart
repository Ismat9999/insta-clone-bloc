import 'package:equatable/equatable.dart';

abstract class MySearchEvent extends Equatable {
  const MySearchEvent();
}

class LoadSearchMemberEvent extends MySearchEvent {
  String keyword;

  LoadSearchMemberEvent({required this.keyword});

  @override
  List<Object?> get props => [];
}
