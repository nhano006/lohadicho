import 'package:lohadicho/model/user.dart';
import 'package:lohadicho/service/data_base.dart';
import 'package:lohadicho/shared/constants.dart';
import 'package:lohadicho/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentSugars;
  String _currentName;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Brew Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => _currentName = val,
                  ),
                  SizedBox(height: 20),
//                  DropdownButtonFormField(
//                      value: _currentSugars ?? userData.sugars,
//                      decoration: textInputDecoration,
//                      items: sugars.map((sugar) {
//                        return DropdownMenuItem(
//                          value: sugar,
//                          child: Text('$sugar sugars'),
//                        );
//                      }).toList(),
//                      onChanged: (value) {
//                        setState(() => _currentSugars = value);
//                      }),
//                  Slider(
//                    value: (_currentStrength??userData.strength).toDouble(),
//                    activeColor: Colors.brown[_currentStrength??userData.strength],
//                    inactiveColor: Colors.brown[_currentStrength??userData.strength],
//                    min: 100,
//                    max: 900,
//                    divisions: 8,
//                    onChanged: (value){
//                      setState(() => _currentStrength = value.round());
//                    },
//                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Update', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ));
        } else {
          return Loading();
        }
      }
    );
  }
}
