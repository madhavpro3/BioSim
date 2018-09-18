// Single particle motion
// unconnected multiparticle motion
// unconnected multiparticle traffic
// connected multiparticle traffic
int NROWS=3;int NCOLS=10;
float SPACE_ROW=30,SPACE_COL=30;

//particle[][] traffic=new particle[NCOLS][NROWS];
multiparticle trafficsim;
int systemClock=0;
void setup(){
  size(500,500);frameRate(10);
  
  randomSeed(0);
  int pauseRIndex=int(random(NROWS));
  int pauseCIndex=int(random(NCOLS));

  trafficsim=new multiparticle(new PVector(width,height));
}

void draw(){
  systemClock+=1;
  background(255);
  println(systemClock);
  
  trafficsim.show();
  
}
