class User{
  final String uid;

  User({this.uid});

  @override
  String toString() {
    return 'User{uid: $uid}';
  }

  bool isAdmin(){
    return true;
  }
}

class UserData{
  final String uid;
  final String name;

  UserData({this.uid, this.name});
}