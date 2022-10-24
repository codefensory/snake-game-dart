library extra_math;

import "dart:math";

double clamp(double curr, double minVal, double maxVal) => min(max(curr, minVal), maxVal);
