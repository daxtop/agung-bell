// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../services/btHelper.dart';

class PlayViewModel extends BaseViewModel {
  BluetoothDriver bluetooth;
  init(BluetoothDriver blue) async {
    this.bluetooth = blue;
  }

  void stop(BuildContext context) {
    bluetooth.isConnected() == false
        ? bluetooth.hubungkan(context)
        : bluetooth.setting(context, "%T", "Stop");
  }

  void play(BuildContext context, String play) {
    bluetooth.isConnected() == false
        ? bluetooth.hubungkan(context)
        : bluetooth.setting(context, "%P", play);
  }
}
