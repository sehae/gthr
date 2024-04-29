import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFDD0A),
      child: Center(
        child: SpinKitPouringHourGlass(
          color: Color(0xff1E7251),
          size: 50.0,
        ),
      ),
    );
  }
}
