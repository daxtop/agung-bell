import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bell/providers/home_view_model.dart';
import 'package:bell/screens/tartil.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => null,
        builder: (context, model, chaild) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue[900],
                title: Text(widget.title),
                actions: [
                  IconButton(
                    icon: Icon(Icons.alarm_add),
                    onPressed: () async {
                      if (model.bluetoothIsConnect == false) {
                        bool connect = await model.btSerial.hubungkan(context);
                        if (connect == true) {
                          setState(() {});
                        }
                      } else {
                        AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.NO_HEADER,
                            title: 'Sinkron waktu',
                            desc:
                                'Samakan waktu di perangkat dengan waktu di android',
                            btnOkOnPress: () {
                              model.updateTime(context);
                            },
                            btnCancelOnPress: () {
                              print("Cancel");
                            }).show();
                      }
                    },
                  ),
                  model.isBusy
                      ? FittedBox(
                          child: Container(
                            margin: new EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : IconButton(
                          // hoverColor: Colors.yellow,
                          color: model.bluetoothIsConnect == true
                              ? Colors.green
                              : Colors.red,
                          splashColor: Colors.red,
                          icon: Icon(model.bluetoothIsConnect == true
                              ? Icons.bluetooth
                              : Icons.bluetooth_disabled),
                          onPressed: () async {
                            await model.bluetoothConnect(context);
                            // bool hasil = await model.btSerial.hubungkan(context);
                            // if (hasil == true) {
                            //   setState(() {});
                            // }
                          })
                ],

                bottom: TabBar(
                  tabs: [
                    // Tab(icon: Icon(Icons.alarm_outlined)),
                    Tab(
                      // icon: Icon(Icons.alarm_outlined),
                      child: Text("Alarm"),
                    ),
                    Tab(
                      // icon: Icon(Icons.alarm_outlined),
                      child: Text("Play"),
                    ),
                    // Tab(icon: Icon(Icons.music_note_outlined)),
                  ],
                ),
                // title: Text('Tabs Demo'),
              ),
              body: TabBarView(
                children: [
                  Tartil(
                    blue: model.btSerial,
                  ),
                  Icon(Icons.directions_car),
                ],
              ),
            ),
          );
        });
  }
}
