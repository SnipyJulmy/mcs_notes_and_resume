#include <Arduino.h>
#include <assert.h>
extern "C" {
    #include <triple_database_interface.h>
}

#define CLEAR_SPO do {\
memset(s,0,1024);\
memset(p,0,1024);\
memset(o,0,1024);\
} while(0);

void setup() {
    // put your setup code here, to run once:

 database_init();

        char s[1024];
        char p[1024];
        char o[1024];

        assert(insert("SOP2018", "has teacher", "PCM") == 0); // => returns 0
        assert(insert("SOP2018", "topic is", "C") == 0);// => returns 0
        assert(insert("PCM", "lastname", "Cudre-Mauroux") == 0);// => returns 0
        CLEAR_SPO;
        assert(match("SOP2018", p, o, 0) == 0);// => returns 0, sets p to "has teacher", sets o to "PCM"
        assert(strcmp(p, "has teacher") == 0);
        assert(strcmp(o, "PCM") == 0);
        CLEAR_SPO;
        assert(match("SOP2018", p, o, 1) == 0);// => returns 0, sets p to "topic is", sets o to "C"
        assert(strcmp(p, "topic is") == 0);
        assert(strcmp(o, "C") == 0);
        CLEAR_SPO;
        assert(match("SOP2018", p, o, 2) == 1);// => returns 1 (no more matches found)
        CLEAR_SPO;
        assert(match(s, "topic is", "C", 0) == 0);// => returns 0, sets s to "SOP2018"
        assert(strcmp(s, "SOP2018") == 0);

        database_free();

}

void loop() {
    // put your main code here, to run repeatedly:
}