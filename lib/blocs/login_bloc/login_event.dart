import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class AccessLogin extends LoginEvent {
  final String pass;
  AccessLogin(this.pass);

  @override
  String toString() => 'AccessLogin';
}

class LoginInit extends LoginEvent {
  @override
  String toString() => 'LoginInit';
}

class LoginFailedCallback extends LoginEvent {
  @override
  String toString() => 'LoginFailedCalback';
}

class LoginSuccessfullyCallback extends LoginEvent {
  @override
  String toString() => 'LoginSuccessfullyCalback';
}
