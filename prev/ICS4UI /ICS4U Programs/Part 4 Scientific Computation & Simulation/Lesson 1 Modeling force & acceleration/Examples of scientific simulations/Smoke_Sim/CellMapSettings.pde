/*
  Easy system to customize and create default settings for the environment
 */
static class CellMapSettings {

  /* *****NOTE****
   You must change Smoke_Sim_v2 line 21 from 
   CellMapSettings.standard() to CellMapSettings.custom()
   to use the settings changed here
   */

  // general environment
  int[] gridSizes = {60, 60};

  float tempSpreadMod = 0.5;           // 1<n
  float ambientTemperature = 20;
  float ambientTempToVelocity = 1.5;
  float risingHeatStrength = 0.000001;  // 1<n keep pretty small

  float smokeSpreadMod = 0.75;         // 1<n
  float maxSmokeCon = 200;
  float smokeResistanceFactor = 5;     // n<1

  float windSpreadMod = 0.01;          // 1<n
  float windTempSpreadFactor = 0.05;   // 1<n  keep pretty small
  float windSmokeSpreadFactor = 1;     // 1<n
  float maxWindSpeed = 2;
  float minWindSpeed = .9;


  // emission parameters
  float emissionSmoke = 800;
  float emissionTemp = 8000;
  PVector emissionDirection = new PVector(-1, 0);
  int emissionLength = 100;

  CellMapSettings() {
  }

  CellMapSettings(int[] gS, float tSM, float aT, float aTV, float rHS, float sSM, float mSC, float sRF, float wSM, float wTSF, float wSSF, float minWS, float maxWS, float eS, float eT, PVector eD, int eL) {
    this.gridSizes = gS;

    this.tempSpreadMod = tSM;
    this.ambientTemperature = aT;
    this.ambientTempToVelocity = aTV;
    this.risingHeatStrength = rHS;

    this.smokeSpreadMod = sSM; 
    this.maxSmokeCon = mSC;
    this.smokeResistanceFactor = sRF;

    this.windSpreadMod = wSM;
    this.windTempSpreadFactor = wTSF;
    this.windSmokeSpreadFactor = wSSF;
    this.maxWindSpeed = minWS;
    this.minWindSpeed = maxWS;

    this.emissionSmoke = eS;
    this.emissionTemp = eT;
    this.emissionDirection = eD.normalize();
    this.emissionLength = eL;
  }

  static CellMapSettings standard() {
    int[] sizes = {40, 40};
    return new CellMapSettings(sizes, 0.5, 20, 1.5, 0.00001, 0.75, 200, 5, 0.01, 0.05, 1, 1, 0.1, 1000, 8000, new PVector(-1, 0), 100);
  }

  static CellMapSettings custom() {
    return new CellMapSettings();
  }
}
