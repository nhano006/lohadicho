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
      DateTime date;
      Timestamp serverDate = doc.data['date'];
      try {
        date = DateTime.fromMicrosecondsSinceEpoch(serverDate.microsecondsSinceEpoch);
      } catch (e) {
        date = DateTime.now();
      }
      Phrase phrase = Phrase(
          context: doc.data['context'] ?? '',
          title: doc.data['title'] ?? '',
          source: doc.data['source'] ?? '',
          date: date
      );
      getPolitician(doc.data['politician']).then((value) => phrase.setPolitician(value));
      getPublisher(doc.data['user']).then((value) => phrase.setPublisher(value));

      return phrase;
    }).toList();
  }

  // userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
    );
  }
  // politicianData from snapshot

  List<Politician> _politiciansFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print('_politiciansFromSnapshot ${doc.data} id: ${doc.documentID}');
      return Politician(name: doc.data['name'], id: doc.documentID);
    }).toList();
  }

  //get user doc Stream
  Stream<UserData> get userData {
    return phraseCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  // get phrases stream
  Stream<List<Phrase>> get phrases {
    return phraseCollection.snapshots().map(_phrasesListFromSnapshot);
  }

  //get politician doc Stream
  Stream<List<Politician>> get politicians {
    return politicianCollection.snapshots().map(_politiciansFromSnapshot);
  }

  Future<Politician> getPolitician(DocumentReference author) async {
    try {
      String pname = await author.get().then((data) => data['name']);
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

  Future createPhrase(String politicianId, String title) async {
    DocumentReference politician;
    politicianCollection.document('/politician/$politicianId').get().then((DocumentSnapshot data) => politician = data.reference);
    print('politician ID: /politician/$politicianId');
    print('politician Reference: $politician');
    if (politicianId == null){
      return null;
    }
    return await phraseCollection.add({
      'politician': politician,
      'title':title
    });
  }
}
