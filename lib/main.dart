import 'package:flutter/material.dart';
import 'package:opart_v1/pages/loading.dart';
import 'package:opart_v1/pages/home.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) => Loading(),
    '/home':(context) => Home(),
  },

));

