import 'package:flutter/material.dart';
import 'package:shop_ke/ui/shared/widgets/app_drawer.dart';

class ChooseActionView extends StatefulWidget {
  static const routeName = '/choose-action';
  @override
  _ChooseActionViewState createState() => _ChooseActionViewState();
}

class _ChooseActionViewState extends State<ChooseActionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Center(
        child: Text('Choose Action'),
      ),
    );
  }
}
