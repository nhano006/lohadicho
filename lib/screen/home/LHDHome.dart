import 'package:lohadicho/model/phrase.dart';
import 'package:lohadicho/screen/home/phrase_tile.dart';
import 'package:lohadicho/screen/home/settings_form.dart';
import 'package:lohadicho/service/auth.dart';
import 'package:lohadicho/service/data_base.dart';
import 'package:lohadicho/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LHDHome extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPannel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Phrase>>.value(
      value: DatabaseService().phrases,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('Lo Ha Dicho!'),
          backgroundColor: barColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPannel(),
                icon: Icon(Icons.settings),
                label: Text('Settings')
            ),
          ],
        ),
        body: Container(
          child: PhraseScroll(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/old_nwsppr-1024x1024.jpg'),
                  fit: BoxFit.cover
              )
          ),
        ),
      )
    );
  }
}