import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void WaitSome() async {

    print('wait 5 seconds');
    await new Future.delayed(const Duration(seconds : 5));
    print('5 seconds gone');

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location':'home sweet home',
    });

  }

  @override
  void initState()  {
    super.initState();
    WaitSome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 200.0,
        ),

      ),

    );
  }
}
