#include <Arduino.h>
#include "DFPlayer.h"
#include "Jadwal.h"
#include "Rtc.h"
#include <SoftwareSerial.h>

// class init
DFRobotDFPlayerMini player = DFRobotDFPlayerMini();
SoftwareSerial serialPlayer(2, 3); // RX, TX
Jadwal waktu01 = Jadwal(1);
Jadwal waktu02 = Jadwal(6);
Jadwal waktu03 = Jadwal(11);
Jadwal waktu04 = Jadwal(16);
Jadwal waktu05 = Jadwal(21);
Jadwal waktu06 = Jadwal(26);
Jadwal waktu07 = Jadwal(31);
Jadwal waktu08 = Jadwal(36);
Jadwal waktu09 = Jadwal(41);
Jadwal waktu10 = Jadwal(46);
Rtc time = Rtc();

//variable
unsigned char jam, menit, once;
const int buzer = 13;

// setup function
void setup()
{
  unsigned char detik;
  pinMode(buzer, OUTPUT);
  digitalWrite(buzer, HIGH);
  Serial.begin(9600);
  Serial.setTimeout(200);
  serialPlayer.begin(9600);
  delay(500);
  digitalWrite(buzer, LOW);
  player.begin(serialPlayer);
  time.getTime(jam, menit, detik);

  Serial.print("AT+NAME");
  Serial.println("bell otomatis");
}

// main fuction
void loop()
{
  //clock
  unsigned char detik;
  //cek jadwal
  if (detik == 0 && once == 0)
  {
    once = 1;
    if (waktu01.onTime(jam, menit))
    {
      player.play(waktu01.getPlay());
    }
    if (waktu02.onTime(jam, menit))
    {
      player.play(waktu02.getPlay());
    }
    if (waktu03.onTime(jam, menit))
    {
      player.play(waktu03.getPlay());
    }
    if (waktu04.onTime(jam, menit))
    {
      player.play(waktu04.getPlay());
    }
    if (waktu05.onTime(jam, menit))
    {
      player.play(waktu05.getPlay());
    }
    if (waktu06.onTime(jam, menit))
    {
      player.play(waktu06.getPlay());
    }
    if (waktu07.onTime(jam, menit))
    {
      player.play(waktu07.getPlay());
    }
    if (waktu08.onTime(jam, menit))
    {
      player.play(waktu08.getPlay());
    }
    if (waktu09.onTime(jam, menit))
    {
      player.play(waktu09.getPlay());
    }
    if (waktu10.onTime(jam, menit))
    {
      player.play(waktu10.getPlay());
    }
  }
  if (detik > 0)
  {
    once = 0;
  }
  time.getTime(jam, menit, detik);
}

const PROGMEM char bloothtCommand[] = {
    'J',
    'S',
    'P',
};

#define command_start 1
#define set_jam 2
#define set_jadwal 3
#define set_play 4
#define command_end 5
volatile static byte command;

void serialEvent()
{
  String input_serial;
  if (Serial.available())
  {
    input_serial = Serial.readString();
    //    Serial.println(input_serial);
  }
  if (input_serial == "1234")
  {
    Serial.print("OK\n");
    command = command_start;
  }
  else
  {
    if (command == command_start)
    {
      if (input_serial[0] == '%')
      {
        for (uint8_t cmd = 0; cmd < 3; cmd++)
        {
          char lookupCmd = pgm_read_byte_near(bloothtCommand + cmd);
          if (lookupCmd == input_serial[1])
          {
            Serial.print("OK");
            Serial.print(lookupCmd);
            Serial.print("\n");
            command = cmd + 2;

            break;
          }
        }
      }
    }
    //===========================================================

    else if (command == set_jam)
    {
      command = command_end;
      //290417040319 // DTK_MNT_JAM_TGL_BLN_TH
      unsigned char jam = ((input_serial[4] - '0') * 10) + (input_serial[5] - '0');
      unsigned char menit = ((input_serial[2] - '0') * 10) + (input_serial[3] - '0');
      unsigned char detik = ((input_serial[0] - '0') * 10) + (input_serial[1] - '0');
      unsigned char tanggal = ((input_serial[6] - '0') * 10) + (input_serial[7] - '0');
      unsigned char bulan = ((input_serial[8] - '0') * 10) + (input_serial[9] - '0');
      unsigned char tahun = 2000 + ((input_serial[10] - '0') * 10) + (input_serial[11] - '0');

      time.setTime(jam, menit, detik);
      time.setTanggal(tanggal, bulan, tahun);
      Serial.print("SetTime\n");
    }

    else if (command == set_jadwal)
    { //OK
      //%S

      unsigned char jam = 0;
      unsigned char menit = 0;
      int music = 0;
      unsigned char index = 0;
      command = command_end;
      for (unsigned char i = 0; i < 10; i++)
      {
        switch (i)
        {
        case 0:
          input_serial[index] == 'Y' ? waktu01.setEnable(true) : waktu01.setEnable(false);
          break;
        case 1:
          input_serial[index] == 'Y' ? waktu02.setEnable(true) : waktu02.setEnable(false);
          break;
        case 2:
          input_serial[index] == 'Y' ? waktu03.setEnable(true) : waktu03.setEnable(false);
          break;
        case 3:
          input_serial[index] == 'Y' ? waktu04.setEnable(true) : waktu04.setEnable(false);
          break;
        case 4:
          input_serial[index] == 'Y' ? waktu05.setEnable(true) : waktu05.setEnable(false);
          break;
        case 5:
          input_serial[index] == 'Y' ? waktu06.setEnable(true) : waktu06.setEnable(false);
          break;
        case 6:
          input_serial[index] == 'Y' ? waktu07.setEnable(true) : waktu07.setEnable(false);
          break;
        case 7:
          input_serial[index] == 'Y' ? waktu08.setEnable(true) : waktu08.setEnable(false);
          break;
        case 8:
          input_serial[index] == 'Y' ? waktu09.setEnable(true) : waktu09.setEnable(false);
          break;
        case 9:
          input_serial[index] == 'Y' ? waktu10.setEnable(true) : waktu10.setEnable(false);
          break;
        }
        index++;
        jam = input_serial[index] * 10;
        index++;
        jam += input_serial[index];
        index++;
        menit = input_serial[index] * 10;
        index++;
        menit += input_serial[index];
        switch (i)
        {
        case 0:
          waktu01.setTime(jam, menit);
          break;
        case 1:
          waktu02.setTime(jam, menit);
          break;
        case 2:
          waktu03.setTime(jam, menit);
          break;
        case 3:
          waktu04.setTime(jam, menit);
          break;
        case 4:
          waktu05.setTime(jam, menit);
          break;
        case 5:
          waktu06.setTime(jam, menit);
          break;
        case 6:
          waktu07.setTime(jam, menit);
          break;
        case 7:
          waktu08.setTime(jam, menit);
          break;
        case 8:
          waktu09.setTime(jam, menit);
          break;
        case 9:
          waktu10.setTime(jam, menit);
          break;
        }

        index++;
        music = input_serial[index] * 1000;
        index++;
        music += input_serial[index] * 100;
        index++;
        music += input_serial[index] * 10;
        index++;
        music += input_serial[index];
        switch (i)
        {
        case 0:
          waktu01.setPlay(music);
          break;
        case 1:
          waktu02.setPlay(music);
          break;
        case 2:
          waktu03.setPlay(music);
          break;
        case 3:
          waktu04.setPlay(music);
          break;
        case 4:
          waktu05.setPlay(music);
          break;
        case 5:
          waktu06.setPlay(music);
          break;
        case 6:
          waktu07.setPlay(music);
          break;
        case 7:
          waktu08.setPlay(music);
          break;
        case 8:
          waktu09.setPlay(music);
          break;
        case 9:
          waktu10.setPlay(music);
          break;
        }
      }

      Serial.print("SetTrkm\n");
    }
    else if (command == set_play)
    { //ok
      //%P
      command = command_end;
      Serial.print("SetBrns\n");
    }
  }

  //===========================================================
  if (command == command_end)
  {
    digitalWrite(buzer, HIGH);
    delay(100);
    digitalWrite(buzer, LOW);

    command = 0;
  }
}