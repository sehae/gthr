import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFFFFF),
      child: const Center(
        child: SpinKitRotatingPlain(
          color: Color(0xff1E7251),
          size: 50.0,
        ),
      ),
    );
  }
}
