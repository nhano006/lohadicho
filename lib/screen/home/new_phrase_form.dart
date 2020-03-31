import 'package:lohadicho/model/people.dart';
import 'package:lohadicho/model/user.dart';
import 'package:lohadicho/service/data_base.dart';
import 'package:lohadicho/shared/constants.dart';
import 'package:lohadicho/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPhraseForm extends StatefulWidget {
  @override
  _AddPhraseFormState createState() => _AddPhraseFormState();
}

class _AddPhraseFormState extends State<AddPhraseForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentTitle;
  String _currentPolitician;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<List<Politician>>(
        stream: DatabaseService(uid: user.uid).politicians,
        builder: (context, politiciansList) {
          if (politiciansList.hasData) {

            return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Han soltado otra',
                      style: titleStyle,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Lumbreras',
                            style: contextStyle,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: DropdownButtonFormField(
                            value: _currentPolitician,
                            decoration: textInputDecoration,
                            items: politiciansList.data.map((Politician politician) {
                              return new DropdownMenuItem<String>(
                                  value: politician.id,
                                  child: new Container(
                                    padding: EdgeInsets.all(2),
                                    //color: primaryColor,
                                    child: new Text(politician.name,
                                        style: nameStyle),
                                  ));
                            }).toList(),
                            onChanged: ((value) {
                              print('changed value to $value');
                              setState(() => _currentPolitician = value);
                            }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Títular',
                            style: contextStyle,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: TextFormField(
                            initialValue:  'barbaridad del día',
                            decoration: textInputDecoration,
                            validator: (val) => val.isEmpty ? 'Resumiendo...' : null,
                            onChanged: (val) => _currentTitle = val,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      color: Colors.pink[400],
                      child:
                          Text('Crear', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid)
                              .createPhrase(_currentPolitician, _currentTitle);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
