import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lohadicho/model/people.dart';
import 'package:lohadicho/model/phrase.dart';
import 'package:lohadicho/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference phraseCollection =
      Firestore.instance.collection('phrases');
  final CollectionReference politicianCollection =
      Firestore.instance.collection('politicians');
  final CollectionReference publisherCollection =
      Firestore.instance.collection('publishers');

  Future updateUserData(String name) async {
    // TODO: WTF here
    return await phraseCollection.document(uid).setData({
      'name': name,
    });
  }

  List<Phrase> _phrasesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print(doc.data);
      Politician politician;
      getPolitician(doc.data['politician']).then((value) => politician = value);
      Publisher publisher;
      getPublisher(doc.data['user']).then((value) => publisher = value);
      DateTime date;
      Timestamp serverDate = doc.data['date'];
      try {
        date = DateTime.fromMicrosecondsSinceEpoch(serverDate.microsecondsSinceEpoch);
      } catch (e) {
        date = DateTime.now();
      }
        return Phrase(
            context: doc.data['context'] ?? '',
            title: doc.data['title'] ?? '',
            source: doc.data['source'] ?? '',
            politician: politician,
            user: publisher,
            date: date
        );
    }).toList();
  }

  // userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
    );
  }

  // get phrases stream
  Stream<List<Phrase>> get phrases {
    return phraseCollection.snapshots().map(_phrasesListFromSnapshot);
  }

  //get user doc Stream
  Stream<UserData> get userData {
    return phraseCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  Future<Politician> getPolitician(DocumentReference author) async {
    try {
      String pname = await author.get().then((data) => data['name']);
      print('pname $pname');
      return Politician(name: pname);
    }
    catch (e){
      return null;
    }
  }

  Future<Publisher> getPublisher(DocumentReference user) async {
    try {
      return Publisher(name: await user.get().then((data) => data['name']));
    }
    catch (e){
      return null;
    }
  }
}
