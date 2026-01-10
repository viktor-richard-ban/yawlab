#include "aero/aero.h"
#include <iostream>
#include <cmath>

int main(void)
{

    double got = rad2deg(M_PI);
    double expected = 180.0;
    if (got != expected) {
        std::cout << "FAIL: expected " << expected << ", got " << got << std::endl;
        return 1;
    }
    std::cout << "OK: rad2deg(M_PI) = " << got << std::endl;

    expected = M_PI;
    got = deg2rad(180.0);
    if (got != expected) {
        std::cout << "FAIL: expected " << expected << ", got " << got << std::endl;
        return 1;
    }

    std::cout << "OK: rad2deg(3.14159) = " << got << std::endl;
    return 0;
}