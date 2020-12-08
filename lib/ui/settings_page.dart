import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';

class SettingsPage extends StatefulWidget {
  static String routeName = 'settings_page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkTheme = false;
  bool _isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: customTextTheme,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text('Pengaturan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Tema Gelap'),
                  trailing: Switch(
                    value: _isDarkTheme,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        _isDarkTheme = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Notifikasi'),
                  trailing: Switch(
                    value: _isNotification,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        _isNotification = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text('Versi Aplikasi'),
                  trailing: Text('1.0.0'),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.center,
            child: Text(
              'Copyright \u00a9 Developed by Risman Abdilah',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: primaryDarkColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
