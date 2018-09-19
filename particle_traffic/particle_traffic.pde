// Single particle motion
// unconnected multiparticle motion
// unconnected multiparticle traffic
// connected multiparticle traffic

multiparticle trafficsim;
int systemClock=0;
void setup(){
  size(500,500);frameRate(10);  
  trafficsim=new multiparticle(new PVector(width,height));
}

void draw(){
  frameRate(5);
  systemClock+=1;
  background(255);
  trafficsim.show(systemClock);  
}