import 'dart:ui';

import 'package:bell/providers/alarm_view_model.dart';
import 'package:bell/services/btHelper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Alarm extends StatefulWidget {
  Alarm({Key key, this.blue}) : super(key: key);
  final BluetoothDriver blue;
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  Future<TimeOfDay> setJam(var contex, TimeOfDay initTime) async {
    TimeOfDay hasil = await showTimePicker(
      context: context,
      initialTime: initTime,
      // TimeOfDay.now(), //TimeOfDay(hour: 10, minute: 47),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // change the border color
              primary: Colors.pink,
              // change the text color
              onSurface: Colors.purple,
            ),
            // button colors
            buttonTheme: ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.green,
              ),
            ),
          ),
          child: child,
        );
      },
    );
    return hasil == null ? initTime : hasil;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return ViewModelBuilder<TartilViewModel>.reactive(
          viewModelBuilder: () => TartilViewModel(),
          onModelReady: (model) => model.init(widget.blue),
          builder: (context, model, chaild) {
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
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Container(
                      //   padding: EdgeInsets.only(top: 15, bottom: 10),
                      //   child: Center(
                      //     child: Text(
                      //       "Pengaturan Tartil",
                      //       style: TextStyle(
                      //           color: model.warnaJudul,
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.w700,
                      //           fontStyle: FontStyle.italic),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      //   child: Divider(
                      //     color: Colors.redAccent[400],
                      //     thickness: 3,
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: 10, //_treatments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(right: 10),
                              height: 60,
                              color: index.isOdd
                                  ? model.warnaOdd
                                  : model.warnaEvent,
                              // height: 55,
                              child: Row(
                                // mainAxisSize: MainAxisAlignment.spaceAround,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Checkbox(
                                          value: model.flag[index],
                                          onChanged: (bool value) async {
                                            await model.enable(index, value);
                                            // print(value);
                                          }),
                                      // value: rememberMe,
                                      // onChanged: _onRememberMeChanged
                                      // );
                                      Text(
                                        model.bell[index],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Switch(
                                      //     value: model.flag[index],
                                      //     onChanged: (bool value) async {
                                      //       await model.enable(index, value);
                                      //       // print(value);
                                      //     }),
                                      //
                                      //
                                      //
                                      GestureDetector(
                                        onTap: () async {
                                          TimeOfDay init = model.getInit(index);
                                          TimeOfDay waktu =
                                              await setJam(context, init);
                                          model.save(index, waktu);
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
                                              Icons.access_time,
                                              size: 20,
                                              color: Colors.orange[900],
                                            ),
                                            Container(
                                              width: 5,
                                            ),
                                            Text(
                                              model.jam[index],
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        thickness: 2,
                                        color: Colors.grey,
                                        indent: 7,
                                        endIndent: 7,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // model.save(index);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.music_note_outlined,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            // Container(
                                            //   width: 10,
                                            // ),
                                            Text(
                                              model.music[index] + ".mp3",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50.0,
                            width: 140,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(0, 160, 227, 1))),
                              onPressed: () {},
                              padding: EdgeInsets.all(10.0),
                              color: Color.fromRGBO(0, 160, 227, 1),
                              textColor: Colors.white,
                              child:
                                  Text("Play", style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50.0,
                            width: 140,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                  side: BorderSide(color: Colors.pink[600])),
                              // color: Color.fromRGBO(0, 160, 227, 1))),
                              onPressed: () {
                                model.kirim(context, widget.blue);
                              },
                              padding: EdgeInsets.all(10.0),
                              color:
                                  Colors.pink //Color.fromRGBO(0, 160, 227, 1),
                              ,
                              textColor: Colors.white,
                              child:
                                  Text("Kirim", style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
