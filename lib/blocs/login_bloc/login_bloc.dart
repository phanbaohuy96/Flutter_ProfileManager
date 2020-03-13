import 'package:bloc/bloc.dart';

import '../bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  // implement initialState
  LoginInitialization get initialState => LoginInitialization();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // implement mapEventToState
    if (event is AccessLogin) {
      yield LoginProcessing();
      yield accessLogin(event.pass);
    } else if (event is LoginFailedCallback) {
      yield LoginFailed();
    } else if (event is LoginSuccessfullyCallback) {
      yield LoginSuccessfully();
    }
    if (event is LoginInit) {
      yield LoginInitialization();
    }
  }

  dynamic accessLogin(String pass) async {
    await Future.delayed(const Duration(seconds: 2));
    if (pass == '123456') {
      dispatch(LoginSuccessfullyCallback());
    } else {
      dispatch(LoginFailedCallback());
    }
  }
}
