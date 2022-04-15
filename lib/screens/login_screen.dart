import 'package:assignment_app/helper/auth.dart';
import 'package:assignment_app/size_config.dart';
import 'package:assignment_app/widgets/change_theme_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _onLogin(String value) async {
    final authData = Provider.of<Auth>(context, listen: false);
    await authData.loginUser(context, value);
    if (!authData.isAuth) {
      final snackbar = SnackBar(
        content: const Text(
          'Wrong passcode',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 15),
        ),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
          actions: [
            const ChangeThemeDropdownWidget(),
            SizedBox(width: getProportionateScreenWidth(15)),
          ],
        ),
        body: Center(
          child: Pinput(
            keyboardType: TextInputType.phone,
            length: 6,
            onCompleted: (value) => _onLogin(value),
            onSubmitted: (value) => _onLogin(value),
          ),
        ),
      ),
    );
  }
}
