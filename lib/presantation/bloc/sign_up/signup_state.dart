abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccsesState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  final String errorMessage;

  SignUpFailureState(this.errorMessage);
}
