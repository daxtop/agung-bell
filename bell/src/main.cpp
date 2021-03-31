#include <Arduino.h>
#include "DFPlayer.h"
#include "Jadwal.h"
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

//variable
unsigned char jam, menit;

// setup function
void setup()
{
  Serial.begin(9600);
  serialPlayer.begin(9600);
  player.begin(serialPlayer);
}

// main fuction
void loop()
{
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