import 'package:lohadicho/model/people.dart';
import 'package:lohadicho/model/phrase.dart';
import 'package:lohadicho/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/getflutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PhraseTile extends StatelessWidget{

  final Phrase phrase;

  PhraseTile({this.phrase});

  @override
  Widget build(BuildContext context) {
    String polName = phrase.politician==null?'':phrase.politician.name;
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 8, 12, 5),
      child: Card(
        color: tileColor,
        child: ListTile(
          leading: GFAvatar(
            backgroundImage: NetworkImage('http://globedia.com/imagenes/noticias/2013/1/20/revista-jueves-enero-2013_1_1539396.jpg'),
            shape: GFAvatarShape.square
          ),
          title: Text(phrase.title),
          subtitle: Row(
            children: <Widget>[
              Text('> $polName'),
              Expanded(child: Container(height: 25,),),
              Text(new DateFormat("EEE, d MMM yyyy").format(phrase.date)),
            ],
          ),
        )
      )
    );
  }
}

class PhraseScroll extends StatefulWidget {
  @override
  _PhraseScrollState createState() => _PhraseScrollState();
}

class _PhraseScrollState extends State<PhraseScroll> {
  @override
  Widget build(BuildContext context) {
  ///////////////////////////////////////////////
    final author1 = Politician(name: 'Jefe  máximo');
    final author2 = Politician(name: 'Pringaillo');
    final publisher1 = Publisher(name: 'motivated');

    final phrase1 = Phrase(
      title: 'Titola 1',
      context: 'donde tu digas',
      source: 'el mundo',
      politician: author1,
      user: publisher1,
      date: DateTime.now()
    );
    final phrase2 = Phrase(
      title: 'Slowodan lo peta',
      context: 'miloseviks house',
      source: 'CNN',
      politician: author2,
      user: publisher1,
      date: DateTime.utc(1992, 12, 3)
    );
    /////////////////////////////////////////////
//    final phrases = [
//      phrase1, phrase2,
//    ].toList();
    final phrases = Provider.of<List<Phrase>>(context)??[];
    phrases.forEach((phrase) {
      print(phrase.title);
    });

    return ListView.builder(
      itemCount: phrases==null?0:phrases.length,
      itemBuilder: (context,index){
        return PhraseTile(phrase: phrases[index]);
      }
    );
  }
}
