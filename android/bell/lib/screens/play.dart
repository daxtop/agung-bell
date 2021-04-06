import 'package:bell/providers/play_view_model.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../services/btHelper.dart';

class Play extends StatefulWidget {
  Play({Key key, this.blue}) : super(key: key);
  final BluetoothDriver blue;
  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlayViewModel>.reactive(
        viewModelBuilder: () => PlayViewModel(),
        onModelReady: (model) => model.init(widget.blue),
        builder: (context, model, chaild) {
          return Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      model.play(context, "0003");
                    },
                    child: Text("Play")),
                ElevatedButton(
                    onPressed: () {
                      model.stop(context);
                    },
                    child: Text("Stop")),
                ElevatedButton(onPressed: () {}, child: Text("Play")),
              ],
            ),
          );
        });
  }
}
