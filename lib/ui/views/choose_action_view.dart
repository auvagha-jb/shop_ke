import 'package:flutter/material.dart';

class ChooseActionView extends StatefulWidget {
  static const routeName = '/choose-action';
  @override
  _ChooseActionViewState createState() => _ChooseActionViewState();
}

class _ChooseActionViewState extends State<ChooseActionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Choose Action'),
      ),
    );
  }
}
