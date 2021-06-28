import 'package:social/models/RegisterModel.dart';

abstract class state {}

class InitialState extends state {}

class changeVisabilty extends state {}

class LoadingLoginState extends state {}

class SuccessfulLoginState extends state {
  final String mess;

  SuccessfulLoginState(this.mess);
}

class ErrorLoginState extends state {
  final String error;

  ErrorLoginState(this.error);
}

class LoadingRegisterState extends state {}

class SuccessfulRegisterState extends state {}

class ErrorRegisterState extends state {
  final String error;

  ErrorRegisterState(this.error);
}

class LoadingCreateUserState extends state {}

class SuccessfulCreateUserState extends state {
  final RegisterModelUser model;

  SuccessfulCreateUserState(this.model);
}

class ErrorCreateUserState extends state {
  final String error;

  ErrorCreateUserState(this.error);
}
