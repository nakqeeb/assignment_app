import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/main_screen.dart';

class Auth with ChangeNotifier {
  bool _isAuth = false;

  String? _password;

  bool get isAuth {
    return _isAuth;
  }

  Future loginUser(BuildContext ctx, String passCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentDay = DateTime.now().day;
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;

    final String result = (currentDay * currentMonth * currentYear).toString();

    if (result.length == 6) {
      _password = result;
      if (_password == passCode) {
        prefs.setString('passCode', result);
        _isAuth = true;
        Navigator.of(ctx).pushNamed(MainScreen.routeName);
        notifyListeners();
      }
      return;
    } else if (result.length < 6 && result.length == 5) {
      _password = '0$result';
      if (_password == passCode) {
        prefs.setString('passCode', '0$result');
        _isAuth = true;
        Navigator.of(ctx).pushNamed(MainScreen.routeName);
        notifyListeners();
      }
      return;
    } else if (result.length < 5) {
      prefs.setString('passCode', '00$result');
      _password = '00$result';
      if (_password == passCode) {
        prefs.setString('passCode', result);
        _isAuth = true;
        Navigator.of(ctx).pushNamed(MainScreen.routeName);
        notifyListeners();
      }
      return;
    }
  }

  Future autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? passCode = prefs.getString('passCode');
    if (passCode!.isNotEmpty) {
      _isAuth = true;
    } else {
      _isAuth = false;
    }
    notifyListeners();
  }

  Future logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('passCode', '');
    _isAuth = false;
    notifyListeners();
  }
}
