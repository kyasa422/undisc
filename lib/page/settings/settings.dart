import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:undisc/page/settings/setting_account.dart';
import 'package:undisc/page/settings/settings_general.dart';
import 'package:undisc/themes/themes.dart';

class SettingsProfile extends StatelessWidget {
  const SettingsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"), 
        backgroundColor: Themes().transparent, 
        foregroundColor: Themes().primary,
        elevation: 0.0,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Material(
            color: Themes().grey100,
            borderRadius: BorderRadius.circular(20.0),
            elevation: 0.0,
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.circleUser),
              title: const Text("Account"),
              textColor: Themes().grey500,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingAccount())),
            ),
          ),
          const SizedBox(height: 10.0,),
          Material(
            color: Themes().grey100,
            borderRadius: BorderRadius.circular(20.0),
            elevation: 0.0,
            child: ListTile(
              leading: const FaIcon(FontAwesomeIcons.gear),
              title: const Text("General"),
              textColor: Themes().grey500,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsGeneral())),
            ),
          ),
        ],
      ),
    );
  }
}