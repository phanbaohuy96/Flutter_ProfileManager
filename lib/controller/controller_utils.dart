import 'package:local_auth/local_auth.dart';

//local auth
enum BiometricAuth{
  faceID,
  touchID,
  none
}

class ControllerUtils{

  //local authentication
  static Future<BiometricAuth> getAvailableBiometrics({BiometricType type = BiometricType.fingerprint}) async {
    List<BiometricType> availableBiometrics = await LocalAuthentication().getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face)) {
      return BiometricAuth.faceID;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return BiometricAuth.touchID;
    }
    return BiometricAuth.none;
  }

  static Future<void> showDefaultPopupCheckBiometricAuth({String message = "", Function(bool) callback}) async{
    var localAuth = LocalAuthentication();
    bool result = await localAuth.authenticateWithBiometrics(
            localizedReason: message);
    if(callback != null)
      callback(result);
  }

  static String getBiometricString(BiometricAuth type)
  {
    switch(type)
    {
      case BiometricAuth.faceID:  return "Face ID";
      case BiometricAuth.touchID: return "Touch ID";
      default:                    return "Touch ID";
    }
  }
}