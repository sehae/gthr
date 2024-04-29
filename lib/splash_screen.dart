import 'package:flutter/material.dart';
import 'package:gthr/screens/wrapper.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/gthr_LogoWithText.png',
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
                   builder: (context) => const Wrapper(),
                 ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff1E7251)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
              ),
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
