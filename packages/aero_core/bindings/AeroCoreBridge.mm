#import "AeroCoreBridge.h"

// Import the C API header (C linkage)
#include "aero/aero.h"

@implementation AeroCoreBridge

+ (double)deg2rad:(double)deg {
    return deg2rad(deg);
}

+ (double)rad2deg:(double)rad {
    return rad2deg(rad);
}

@end
