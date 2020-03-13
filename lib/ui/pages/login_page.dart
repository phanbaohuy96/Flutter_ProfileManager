import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_manager/controller/biometric_local_auth.dart';
import 'package:profile_manager/ui/widget/app_background_view.dart';
import 'package:profile_manager/ui/widget/submit_button_view.dart';
import 'package:profile_manager/ui/widget/textfield_numberic_password.dart';
import '../../blocs/bloc.dart';
import 'menu_dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _loginBloc = LoginBloc();
  Size _buttonLoginSize = const Size(0, 0);
  BiometricAuth _biometricType;
  String _pass = '';

  void onLogin() {
    _loginBloc.dispatch(AccessLogin(_pass));
  }

  Future<void> onPasswordInputChanged(String pass) async {
    _pass = pass;
  }

  void onPasswordReachedLimit(String pass) {
    _pass = pass;
    onLogin();
  }

  Widget _buildLoginBtnByStatus(ButtonStatus status, Function onTap,
      {Function onRollBackCompleted}) {
    return SubmitButtonView(
      size: _buttonLoginSize,
      text: Text('Sign in',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          )),
      status: status,
      onTap: onTap,
      onRoolBackCompleted: onRollBackCompleted,
    );
  }

  Future<void> _checkBiometricable() async {
    _biometricType = await BiometricUtils.getAvailableBiometrics();
    if (_biometricType != BiometricAuth.none) {
      setState(() {
        _showLocalAuthPopup(BiometricUtils.getBiometricString(_biometricType));
      });
    }
  }

  Future<void> _showLocalAuthPopup(String biometric) async {
    TextfieldNumbericPassword.textfieldState.notifyTextChange('');
    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
      message: 'Please use $biometric to unlock!',
      callback: (result) {
        setState(
          () {
            if (result) {
              TextfieldNumbericPassword.textfieldState
                  .notifyTextChange('123456');
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    _checkBiometricable();
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size contextSize = MediaQuery.of(context).size;
    _buttonLoginSize = Size(contextSize.width * 0.7, 50);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBackgroundView(),
          GestureDetector(onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: contextSize.width,
                height: contextSize.height * 0.25,
              ),
              TextfieldNumbericPassword(
                height: 50,
                width: _buttonLoginSize.width,
                hint: 'Enter password!',
                text: _pass,
                onTextChanged: onPasswordInputChanged,
                onTextReachedLimit: onPasswordReachedLimit,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: BlocBuilder(
                  bloc: _loginBloc,
                  builder: (BuildContext context, LoginState state) {
                    if (state is LoginInitialization) {
                      return _buildLoginBtnByStatus(
                        ButtonStatus.original,
                        onLogin,
                      );
                    } else if (state is LoginSuccessfully) {
                      _pass = '';
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuDashboardPage(),
                          ),
                        );
                        return;
                      });
                      _loginBloc.dispatch(LoginInit());
                      return Container();
                    } else if (state is LoginFailed) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            'Username or password is incorrect.',
                          ),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        ));
                      });
                      return _buildLoginBtnByStatus(
                        ButtonStatus.rollback,
                        onLogin,
                        onRollBackCompleted: () => _loginBloc.dispatch(
                          LoginInit(),
                        ),
                      );
                    } else if (state is LoginProcessing) {
                      return _buildLoginBtnByStatus(
                          ButtonStatus.tranform, null);
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 25),
              _biometricType != BiometricAuth.none
                  ? InkWell(
                      onTap: () {
                        _showLocalAuthPopup(
                          BiometricUtils.getBiometricString(_biometricType),
                        );
                      },
                      child: SizedBox(
                        width: _buttonLoginSize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                              width: 30,
                              child: Image.asset(
                                'assets/images/fringer_print.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '''Unlock by ${BiometricUtils.getBiometricString(_biometricType)}''',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          )
        ],
      ),
    );
  }
}
