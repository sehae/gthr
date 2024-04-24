import 'package:flutter/cupertino.dart';
import 'package:gthr/main.dart';
import 'package:gthr/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    final user = Provider.of<myUser?>(context);

    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}