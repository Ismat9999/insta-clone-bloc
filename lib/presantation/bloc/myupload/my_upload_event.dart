import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class MyUploadEvent extends Equatable {
  const MyUploadEvent();
}

class UploadPostsEvent extends MyUploadEvent {
  String caption;
  File image;

  UploadPostsEvent({required this.caption, required this.image});
  @override
  List<Object?> get props => [];
}
