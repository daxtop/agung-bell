#include <EEPROM.h>
#if !defined(Jadwal_h)
#define Jadwal_h
//Header
class Jadwal
{
private:
    /* data */
    int time;
    int addr;
    bool enable;
    int play;

public:
    Jadwal(int addr);
    ~Jadwal();
    void setTime(unsigned char jam, unsigned char menit);
    bool onTime(unsigned char jam, unsigned char menit);
    void writeIntIntoEEPROM(int address, int number);
    int readIntFromEEPROM(int address);
    bool isEnable();
    void setEnable(bool en);
    void setPlay(int ply);
    int getPlay();
};

#endif // Jadwal_h
