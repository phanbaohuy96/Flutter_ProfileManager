import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_manager/controller/controller_utils.dart';
import 'package:profile_manager/views/commons/textfield_numberic_password.dart';
import 'package:profile_manager/views/pages/profile_info_page.dart';
import '../../models/user.dart';
import '../commons/app_background_view.dart';
import '../commons/submit_button_view.dart';
import '../../blocs/bloc.dart';
import 'menu_dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final _loginBloc = LoginBloc();
  Size _buttonLoginSize = Size(0, 0);
  TextEditingController _editingUserNameController, _editingPassController;
  bool canCheckBiometric;
  String _pass = "";
  

  onLogin(){
    _loginBloc.dispatch(AccessLogin(_pass));
  }

  onPasswordInputChanged(String pass)
  {
    _pass = pass;
  }

  onPasswordReachedLimit(String pass)
  {
    _pass = pass;
    onLogin();
  }

  _genLoginBtnByStatus(ButtonStatus status, Function onTap, {Function onRollBackCompleted})
  {
    return SubmitButtonView(
      size: _buttonLoginSize,
      text: Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w300, letterSpacing: 0.3,)),
      status: status,
      onTap: onTap,
      onRoolBackCompleted: onRollBackCompleted,
    );
  }

  @override
  void initState() {
    canCheckBiometric = ControllerUtils.getAvailableBiometrics() != BiometricAuth.none;
    _editingUserNameController = TextEditingController();
    _editingPassController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    Size contextSize = MediaQuery.of(context).size;
    _buttonLoginSize = Size(contextSize.width * 0.7, 50);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackgroundView(),
          GestureDetector(
            onTap:(){
              FocusScope.of(context).requestFocus(new FocusNode());
            }
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: contextSize.width, height: contextSize.height * 0.25,),
              TextfieldNumbericPassword(
                height: 50, 
                width: _buttonLoginSize.width, 
                hint: "Enter password!",
                onTextChanged: onPasswordInputChanged,
                onTextReachedLimit: onPasswordReachedLimit,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: BlocBuilder(
                  bloc: _loginBloc,
                  builder: (BuildContext context, LoginState state){
                    if(state is LoginInitialization)
                    {        
                      return _genLoginBtnByStatus(ButtonStatus.original, onLogin);
                    } else if (state is LoginSuccessfully){ 
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => MenuDashboardPage())
                        );
                        return;
                      });
                      _loginBloc.dispatch(LoginInit());
                      return Container();

                    } else if (state is LoginFailed){
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        print("Show error!");
                        Scaffold.of(context).showSnackBar( 
                          SnackBar( 
                            content: Text('Username or password is incorrect.'), 
                            backgroundColor: Colors.red, 
                            duration: Duration(seconds: 2),
                            )
                          );
                      });
                      return _genLoginBtnByStatus(ButtonStatus.rollback, onLogin, onRollBackCompleted: () => _loginBloc.dispatch(LoginInit()));

                    } else if(state is LoginProcessing)
                    {
                      return _genLoginBtnByStatus(ButtonStatus.tranform, null);
                    }
                    return null;                    
                  },
                )
              ),
            ],
          )
        ],
      ),      
    );
  }
}