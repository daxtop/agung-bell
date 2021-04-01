import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../services/btHelper.dart';
import 'memori.dart';

class TartilViewModel extends BaseViewModel {
  final bell = [
    'Bell 01',
    'Bell 02',
    'Bell 03',
    "Bell 04",
    "Bell 05",
    'Bell 06',
    'Bell 07',
    'Bell 08',
    "Bell 09",
    "Bell 10"
  ];
  List<String> jam = [
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00",
    "00:00"
  ];
  List<String> music = [
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000",
    "0000"
  ];
  List<bool> flag = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  BluetoothDriver bluetooth;
  Memori _eprom = new Memori();

  get warnaBackground => Colors.pink[100];
  get warnaJudul => Colors.redAccent[700];
  get warnaOdd => Colors.pink[50];
  get warnaEvent => Colors.pink[100];

  // get getflag => null;

  void kirim(BuildContext context, BluetoothDriver x) async {
    String kirim = '';
    // kirim += value[0] < 0 ? '0' : '1';
    // kirim += value[0].abs().toString();
    // kirim += value[1] < 0 ? '0' : '1';
    // kirim += value[1].abs().toString();
    // kirim += value[2] < 0 ? '0' : '1';
    // kirim += value[2].abs().toString();
    // kirim += value[3] < 0 ? '0' : '1';
    // kirim += value[3].abs().toString();
    // kirim += value[4] < 0 ? '0' : '1';
    // kirim += value[4].abs().toString();

    // NYNYN12061203120712051833

    // for (var i = 0; i < 5; i++) {
    //   kirim += flag[i] == true ? 'Y' : 'N';
    // }
    // for (var i = 0; i < 5; i++) {
    //   kirim += tartil[i].replaceAll(new RegExp(r':'), '');
    // }
    for (var i = 0; i < 10; i++) {
      flag[i] == true ? kirim += 'Y' : kirim += 'N';
      kirim += jam[i].substring(0, 2);
      kirim += jam[i].substring(3);
      kirim += music[i];
    }
    print(kirim);
    // bluetooth.isConnected() == false
    //     ? bluetooth.hubungkan(context)
    //     : bluetooth.setting(context, "%X", kirim);
  }

  init(BluetoothDriver blue) async {
    this.bluetooth = blue;
    for (var i = 0; i < 10; i++) {
      jam[i] = await _eprom.getString("jam" + i.toString()) ?? "00:00";
      if (jam[i] == '') {
        jam[i] = '00:00';
      }
      music[i] = await _eprom.getString("music" + i.toString()) ?? "0000";
      if (music[i] == '') {
        music[i] = '0000';
      }
      flag[i] = await _eprom.getBool("flag" + i.toString()) ?? false;
    }
    notifyListeners();
  }

  Future<void> save(int index, TimeOfDay waktu) async {
    jam[index] =
        waktu.hour < 10 ? '0' + waktu.hour.toString() : waktu.hour.toString();
    jam[index] += ':';
    jam[index] += waktu.minute < 10
        ? '0' + waktu.minute.toString()
        : waktu.minute.toString();
    await _eprom.setString("jam" + index.toString(), jam[index]);
    notifyListeners();
    // await _eprom.setInt("koreksiJadwal" + i.toString(), 0);
  }

  Future<void> enable(int index, bool value) async {
    flag[index] = value;
    await _eprom.setBool("flag" + index.toString(), value);
    notifyListeners();
  }

  TimeOfDay getInit(int index) {
    String hour = jam[index].substring(0, 2);
    String menit = jam[index].substring(3);
    TimeOfDay init = TimeOfDay(hour: int.parse(hour), minute: int.parse(menit));
    return init;
  }
}
