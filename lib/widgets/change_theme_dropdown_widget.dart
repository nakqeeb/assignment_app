import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/theme_provider.dart';

class ChangeThemeDropdownWidget extends StatelessWidget {
  const ChangeThemeDropdownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (ctx, provider, _) {
      return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: provider.currentTheme,
          icon: const Icon(
            Icons.arrow_circle_down,
          ),
          items: const [
            //Light, dark, and system
            DropdownMenuItem<String>(
              value: 'light',
              child: Text(
                'Light',
              ),
            ),

            DropdownMenuItem<String>(
              value: 'dark',
              child: Text(
                'Dark',
              ),
            ),
            DropdownMenuItem<String>(
              value: 'system',
              child: Text(
                'System',
              ),
            ),
          ],
          onChanged: (String? value) {
            provider.changeTheme(value ?? 'system');
          },
        ),
      );
    });
  }
}
