import 'package:bloom/ui/screens/profile_page.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {

  // final ValueChanged<bool> onThemeChanged;
  const SettingPage({super.key, });


  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

 bool isDarkMode= false;
 bool notificationsEnabled = true;
 bool languageEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
                title: const Text('Account'),
                trailing: IconButton(onPressed: (){
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const ProfilePage())
                  );
                },
                  icon: const Icon(Icons.arrow_forward_ios),)
            ),

            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    // widget.onThemeChanged(value);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Enable Notifications'),
              trailing: Switch(
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });

                },
              ),
            ),
            ListTile(
              title: const Text('Arabic Language'),
              trailing: Switch(
                value: languageEnabled,
                onChanged: (value) {
                  setState(() {
                    languageEnabled = value;
                  });
                },
              ),
            ),
            ListTile(
                title:const Text('Logout'),
                trailing: IconButton(onPressed: (){},
                  icon:const Icon(Icons.arrow_forward_ios),)
            ),

          ],
        ),
      ),
    );
  }
}