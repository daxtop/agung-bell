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
          // return Center(
          //   child: Column(
          //     children: [
          //       ElevatedButton(
          //           onPressed: () {
          //             model.play(context, "0003");
          //           },
          //           child: Text("Play")),
          //       ElevatedButton(
          //           onPressed: () {
          //             model.stop(context);
          //           },
          //           child: Text("Stop")),
          //       ElevatedButton(onPressed: () {}, child: Text("Play")),
          //     ],
          //   ),
          // );
          return Container(
            color: model.warnaBackground,
            padding: EdgeInsets.all(2),
            child: Card(
              child: Container(
                margin: EdgeInsets.only(
                  top: 3,
                  bottom: 3,
                  left: 3,
                  right: 3,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.separated(
                        itemCount: 10000, //_treatments.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(right: 10),
                            height: 60,
                            color:
                                index.isOdd ? model.warnaOdd : model.warnaEvent,
                            // height: 55,
                            child: Row(
                              // mainAxisSize: MainAxisAlignment.spaceAround,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                    ),
                                    Text(
                                      index.toString().padLeft(4, '0') + ".mp3",
                                      // model.bell[index],
                                      style: TextStyle(
                                          color: Colors.grey[700],

                                          // fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.left,
                                    ),
                                    Container(
                                      width: 20,
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        model.play(context,
                                            index.toString().padLeft(4, '0'));
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          // Container(
                                          //   width: 20,
                                          // ),
                                          Icon(
                                            Icons.play_arrow,
                                            size: 25,
                                            color: Colors.green,
                                          ),
                                          Container(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        model.stop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.stop,
                                            size: 25,
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // ),
                          );
                        },
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.5),
                          // child: Divider(
                          //   height: 1.0,
                          //   thickness: 1.0,
                          //   indent: 15.0,
                          //   endIndent: 15.0,
                          //   // color: kDividerColor,
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
