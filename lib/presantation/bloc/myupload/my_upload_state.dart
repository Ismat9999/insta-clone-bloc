abstract class MyUploadState {}

class UploadInitialState extends MyUploadState {}

class UploadLoadingState extends MyUploadState {}

class UploadSuccsesState extends MyUploadState {}

class UploadFailureState extends MyUploadState {
  final String errorMessage;

  UploadFailureState(this.errorMessage);
}
