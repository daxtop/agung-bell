#include "Jadwal.h"
//main class

bool Jadwal::onTime(unsigned char jam, unsigned char menit)
{
    int compare = (jam * 60) + menit;
    if (compare == this->time && enable == true)
    {
        return true;
    }
    else
    {
        return false;
    }
}
void Jadwal::setPlay(unsigned char ply)
{
    play = ply;
    EEPROM.write(this->addr + 3, ply);
}
unsigned char Jadwal::getPlay()
{
    return play;
}
bool Jadwal::isEnable()
{
    return enable;
}
void Jadwal::setEnable(bool en)
{
    enable = en;
    if (enable)
    {
        EEPROM.write(this->addr + 2, 0xff);
    }
    else
    {
        EEPROM.write(this->addr + 2, 0);
    }
}
void Jadwal::setTime(unsigned char jam, unsigned char menit)
{
    this->time = (jam * 60) + menit;
    writeIntIntoEEPROM(this->addr, this->time);
}

void Jadwal::writeIntIntoEEPROM(int address, int number)
{
    EEPROM.write(address, number >> 8);
    EEPROM.write(address + 1, number & 0xFF);
}

int Jadwal::readIntFromEEPROM(int address)
{
    unsigned char byte1 = EEPROM.read(address);
    unsigned char byte2 = EEPROM.read(address + 1);

    return (byte1 << 8) + byte2;
}
Jadwal::Jadwal(int addr)
{
    this->addr = addr;
    this->time = readIntFromEEPROM(addr);
    unsigned char en = EEPROM.read(this->addr + 2);
    if (en > 0)
    {
        enable = true;
    }
    else
    {
        enable = false;
    }
    play = EEPROM.read(this->addr + 3);
}

Jadwal::~Jadwal()
{
}
