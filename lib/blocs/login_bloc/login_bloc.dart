import 'package:bloc/bloc.dart';
import 'package:profile_manager/models/user.dart';

import '../bloc.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>
{
  @override
  // TODO: implement initialState
  get initialState => LoginInitialization();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    // TODO: implement mapEventToState
    if(event is AccessLogin)
    {
      yield LoginProcessing(); 
      yield accessLogin(event.pass);
    } else if(event is LoginFailedCallback)
    {
      yield LoginFailed();  
    } else if(event is LoginSuccessfullyCallback)
    {
      yield LoginSuccessfully();  
    }
    if(event is LoginInit)
    {
      yield LoginInitialization();  
    }

  }

  accessLogin(String pass) async{
    await Future.delayed(Duration(seconds: 2));
    if(pass == "123456")
    {
      this.dispatch(LoginSuccessfullyCallback());
    }else{
      this.dispatch(LoginFailedCallback());
    }
  }
  
}