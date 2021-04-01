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
                    Tab(icon: Icon(Icons.alarm_outlined)),
                    Tab(icon: Icon(Icons.music_note_outlined)),
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

              // Container(
              //   margin: EdgeInsets.only(top: 7),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 7, right: 7),
              //     child: GridView.count(
              //       crossAxisCount: 3,
              //       children: <Widget>[
              //         Menu(
              //           gambar: Icons.sync, //PixIcon.fa_sync,
              //           text: 'Sinkronisasi waktu',
              //           warna: Colors.green,
              //           onClick: () async {
              //             if (model.bluetoothIsConnect == false) {
              //               bool connect =
              //                   await model.btSerial.hubungkan(context);
              //               if (connect == true) {
              //                 setState(() {});
              //               }
              //             } else {
              //               AwesomeDialog(
              //                   context: context,
              //                   headerAnimationLoop: false,
              //                   dialogType: DialogType.NO_HEADER,
              //                   title: 'Sinkron waktu',
              //                   desc:
              //                       'Samakan waktu di perangkat dengan waktu di android',
              //                   btnOkOnPress: () {
              //                     model.updateTime(context);
              //                   },
              //                   btnCancelOnPress: () {
              //                     print("Cancel");
              //                   }).show();
              //             }
              //           },
              //         ),
              //         Menu(
              //           gambar: Icons.home, //
              //           warna: Colors.blue,
              //           text: 'Edit Text',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.volume_down,
              //           text: 'Seting Kota',
              //           warna: Colors.red,
              //           onClick: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => Tartil(
              //                   blue: model.btSerial,
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //         Menu(
              //           gambar: Icons.access_alarms_outlined,
              //           warna: Colors.yellow,
              //           text: 'Kecerahan',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.play_arrow,
              //           warna: Colors.pink,
              //           text: 'Alarm',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.pause,
              //           warna: Colors.purple,
              //           text: 'Iqomah',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.stop,
              //           warna: Colors.pink,
              //           text: 'Fix Jadwal',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.contact_support_outlined,
              //           warna: Colors.brown,
              //           text: 'Koreksi Jadwal',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.lock_clock,
              //           warna: Colors.greenAccent,
              //           text: 'Lama Adzan',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.settings_backup_restore,
              //           warna: Colors.blueAccent,
              //           text: 'Reset Pabrik',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.battery_charging_full,
              //           warna: Colors.redAccent,
              //           text: 'Tartil',
              //           onClick: () {},
              //         ),
              //         Menu(
              //           gambar: Icons.settings,
              //           warna: Colors.blueGrey,
              //           text: 'Pengaturan',
              //           onClick: () {},
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {},
              //   tooltip: 'Increment',
              //   child: Icon(Icons.add),
              // ),
            ),
          );
        });
  }
}

class Menu extends StatelessWidget {
  Menu({this.gambar, this.warna, this.text, this.onClick});
  final IconData gambar;
  final String text;
  final Color warna;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: EdgeInsets.all(1.50),
        color: Colors.black12,
        // color: Colors.white10,
        // borderRadius: BorderRadius.all(Radius.circular(10)),
        // child: new Material(
        child: new InkWell(
          // borderRadius: BorderRadius.all(Radius.circular(10)),
          splashColor: Colors.greenAccent,
          onTap: () {
            onClick();
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  gambar,
                  size: 55,
                  color: warna,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 12.0),
                )
              ],
            ),
          ),
        ),
        // color: Colors.transparent,
        // ),
      ),
    );
  }
}
