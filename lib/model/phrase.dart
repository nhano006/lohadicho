import 'people.dart';

class Phrase {
  final String title;
  final String context;
  final String source; // link
  int nOK;
  int nKO;
  int nFN;
  final Politician politician;
  final Publisher user;
  final DateTime date;

  Phrase(
      {this.title,
      this.context,
      this.source,
      this.politician,
      this.user,
      this.date});
}
