import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/color_theme_data.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSwitched = Provider.of<ColorThemeData>(context).isGreen;

    Text greenText =
        Text("Green", style: TextStyle(color: Theme.of(context).primaryColor));
    Text darkText =
        Text("Dark Mode", style: TextStyle(color: Theme.of(context).primaryColorLight));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Card(
        color: Colors.transparent,
        elevation: 0.5,
        child: SwitchListTile(
          value: isSwitched,
          onChanged: (bool value) {
            isSwitched = value;
                 Provider.of<ColorThemeData>(context, listen: false).switchTheme(value);
          },
          title: const Text("Switch Theme Color",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: isSwitched ? greenText : darkText,
        ),
      ),
    );
  }
}
