void setInitialValues() {
  xInit[0] = 0.2;
  yInit[0] = 0.2;
  xSpeeds[0] = 9;
  ySpeeds[0] = -4;
  t[0] = 0;
  
  for(int i=1; i< xInit.length; i++) {
    xInit[i] = xInit[i-1];
    yInit[i] = yInit[i-1];
    xSpeeds[i] = xSpeeds[i-1] * speedIncreaseFactor;
    ySpeeds[i] = ySpeeds[i-1] * speedIncreaseFactor;
    t[i] = 0;
  }
}
