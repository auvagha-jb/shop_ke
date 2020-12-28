import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shop_ke/core/enums/view_state.dart';

///Keeps track of the state of the UI
class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void changeState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void delayedChangeState(ViewState viewState) {
    Timer(const Duration(milliseconds: 3000), () {
      changeState(viewState);
    });
  }
}
