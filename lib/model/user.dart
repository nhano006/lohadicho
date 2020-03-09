class User{
  final String uid;

  User({this.uid});

  @override
  String toString() {
    return 'User{uid: $uid}';
  }
}

class UserData{
  final String uid;
  final String name;

  UserData({this.uid, this.name});
}