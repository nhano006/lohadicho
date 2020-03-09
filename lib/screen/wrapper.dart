import 'package:flutter/material.dart';
import 'package:lohadicho/model/user.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'home/LHDHome.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return either home/authenticate widget
    print('user $user');
    if (user != null){
      print('user is not null!');
      return LHDHome();
    } else {
      print('meeec!');
      return Authenticate();
    }
  }
}