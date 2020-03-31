import 'package:lohadicho/screen/home/phrase_tile.dart';

import 'people.dart';

class Phrase {
  final String title;
  final String context;
  final String source; // link
  int nOK;
  int nKO;
  int nFN;
  Politician politician;
  Publisher publisher;
  final DateTime date;

  PhraseTileState tileState;

  Phrase(
      {this.title,
      this.context,
      this.source,
      this.date});

  void setPolitician(Politician politician){
    try {
      tileState.setState(() => this.politician = politician); // ignore: invalid_use_of_protected_member
    } catch (e) {
        this.politician = politician;
    }
  }
  void setPublisher(Publisher publisher){
    this.publisher = publisher;
  }

  void setTileState(phraseTileState) {
    this.tileState = phraseTileState;
  }
}
