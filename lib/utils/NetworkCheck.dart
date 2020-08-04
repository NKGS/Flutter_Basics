import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((intenet) {
      print('internet $intenet');
      if (intenet != null && intenet) {
        func(true);
      }
      else{
        print('internet in else');
    func(false);
  }
    });
  }
}