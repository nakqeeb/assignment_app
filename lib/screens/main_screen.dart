import 'package:assignment_app/screens/login_screen.dart';
import 'package:assignment_app/widgets/change_theme_dropdown_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/auth.dart';
import '../helper/theme_provider.dart';
import '../size_config.dart';

class MainScreen extends StatelessWidget {
  static String routeName = 'home';
  MainScreen({Key? key}) : super(key: key);

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'nakqeeb@gmail.com',
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // init sizeConfig because I need to use getProportionateScreenWidth
    SizeConfig().init(context);
    // check system mode (dark or light) mode
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isSystemInDarkMode = brightness == Brightness.dark;

    bool isDarkMode =
        themeProvider.themeMode == ThemeMode.dark || isSystemInDarkMode;
    bool isLightMode =
        themeProvider.themeMode == ThemeMode.light || !isSystemInDarkMode;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            const ChangeThemeDropdownWidget(),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              tooltip: 'Logout',
              onPressed: () async {
                final authData = Provider.of<Auth>(context, listen: false);
                await authData.logout();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (route) => false);
              },
            ),
          ]),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(70),
              bottom: getProportionateScreenHeight(70)),
          child: Column(
            children: [
              Container(
                width: getProportionateScreenWidth(200),
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: isDarkMode && !isLightMode
                      ? Colors.blueGrey[900]
                      : Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 22,
                      color: Colors.blueGrey.withOpacity(0.8),
                    ),
                    /* BoxShadow(
                      offset: const Offset(-15, -15),
                      blurRadius: 20,
                      color: Colors.blueGrey.withOpacity(0.8),
                    ), */
                  ],
                ),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: 'Hello, my name is Khaled Gamal. ',
                    style: TextStyle(
                      color: isDarkMode && !isLightMode
                          ? Colors.blueGrey[100]
                          : Colors.blueGrey[900],
                    ),
                    children: [
                      const TextSpan(
                          text:
                              'I have created this app as required in the given assignment. Also I have used provider along with shared preferences package to save the current state of the app (logging state and theme mode state) in the local storage. This app is created in landscape mode as required. Feel free to send me your feedback at '),
                      TextSpan(
                        text: 'nakqeeb@gmail.com',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(emailLaunchUri.toString());
                          },
                      ),
                      const TextSpan(text: '\n\nThank you 😊'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
