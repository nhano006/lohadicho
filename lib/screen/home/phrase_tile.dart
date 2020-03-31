import 'package:lohadicho/model/phrase.dart';
import 'package:lohadicho/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PhraseTile extends StatefulWidget {
  final Phrase phrase;

  PhraseTile({this.phrase});

  @override
  State<StatefulWidget> createState() => PhraseTileState(phrase: this.phrase);
}

class PhraseTileState extends State<PhraseTile> {
  final Phrase phrase;
  String polName;

  PhraseTileState({this.phrase}) {
    phrase.setTileState(this);
  }

  @override
  Widget build(BuildContext context) {
    polName = phrase.politician == null ? '' : phrase.politician.name;
    print('polName: $polName');
    return Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 5),
        child: Container(
          color: tileColor,
          child: Column(
            children: <Widget>[
              Card(
                  child: ListTile(
                    leading: GFAvatar(
                        backgroundImage: NetworkImage(
                            'http://globedia.com/imagenes/noticias/2013/1/20/revista-jueves-enero-2013_1_1539396.jpg'),
                        shape: GFAvatarShape.square),
                    title: Text(phrase.title, style: titleStyle,),
                    subtitle: Row(
                      children: <Widget>[
                        Text('> $polName', style: nameStyle),
                        Expanded(
                          child: Container(
                            height: 25,
                          ),
                        ),
                        Text(new DateFormat("EEE, d MMM yyyy")
                            .format(phrase.date)),
                      ],
                    ),
                  )),
              ListTile(
                title: Text(
                  phrase.context,
                  style: contextStyle,
                  textAlign: TextAlign.left,
                ),
                subtitle: InkWell(
                  child: Text(phrase.source,
                      style: linkStyle,
                      textAlign: TextAlign.right),
                  onTap: () => launch(
                      'https://docs.flutter.io/flutter/services/UrlLauncher-class.html'),
                ),
              )
            ],
          ),
        ));
  }
}

class PhraseScroll extends StatefulWidget {
  @override
  _PhraseScrollState createState() => _PhraseScrollState();
}

class _PhraseScrollState extends State<PhraseScroll> {
  @override
  Widget build(BuildContext context) {
    final phrases = Provider.of<List<Phrase>>(context) ?? [];
    phrases.forEach((phrase) {
      print('title: ${phrase.title}');
    });

    return ListView.builder(
        itemCount: phrases == null ? 0 : phrases.length,
        itemBuilder: (context, index) {
          return PhraseTile(phrase: phrases[index]);
        });
  }
}
