//TODO
/*
  Avoid collision
*/

int numBoids=10;
float neighbourhoodDistance=20;
PVector[] position=new PVector[numBoids];
float[] iDirection=new float[numBoids];
float[] curDirection=new float[numBoids];
boolean[] isBoidColliding=new boolean[numBoids];
boid[] boids=new boid[numBoids];

float[][] distanceMatrix=new float[numBoids][numBoids];
short[][] neighbourhoodMatrix=new short[numBoids][numBoids];
float[] flockDirection=new float[numBoids];
float[] collisionAvoidanceDirection=new float[numBoids];

void setup(){
  size(500,500);
  background(255);
  for(int i=0;i<numBoids;i++){
    position[i]=new PVector(i*width/numBoids,i*height/numBoids);
    //position[0]=new PVector(0,0.5*height);
    //position[1]=new PVector(width,0.5*height);
    iDirection[i]=i*2*PI/numBoids;
    curDirection[i]=iDirection[i];
    boids[i]=new boid(position[i],iDirection[i]);
    isBoidColliding[i]=false;
  }
  
};

  void draw(){
  background(255);   //<>//
  for(int i=0;i<numBoids;i++){
    for(int j=0;j<numBoids;j++){
      
      if(j<i){
        distanceMatrix[i][j]=distanceMatrix[j][i];
        neighbourhoodMatrix[i][j]=neighbourhoodMatrix[j][i];
      }
      else{
        distanceMatrix[i][j]=distance(boids[i].getPosition(),boids[j].getPosition());
        if(distanceMatrix[i][j]<neighbourhoodDistance){
          neighbourhoodMatrix[i][j]=1;
        }
        else{
          neighbourhoodMatrix[i][j]=0;
        }
      }
      
    }
  }
  
  //direction based on the neighbours
  for(int i=0;i<numBoids;i++){
    float dir=0;
    for(int ii=0;ii<numBoids;ii++){
      dir+=boids[ii].getDirection()*neighbourhoodMatrix[i][ii];
    }
    
    int numNeighbours=0;
    for(int ii=0;ii<numBoids;ii++){
      numNeighbours+=neighbourhoodMatrix[i][ii];
    }
    dir/=numNeighbours;
    flockDirection[i]=dir;
  }
  
  //direction to avoid collision
  
  for(int i=0;i<numBoids;i++){
    boids[i].setDirection(flockDirection[i]);
    boids[i].move();
    if(isBoidColliding[i]){
      //boids[i].setFillColor(color(255,0,0));    
      isBoidColliding[i]=false;
    }
    else{
      //boids[i].setFillColor(color(0,0,0));    
    }
    boids[i].show();
  }
 };

float vectorDirection(PVector p1,PVector p2){
  return atan2(p1.y-p2.y,p1.x-p2.x);
}
float distance(PVector p1,PVector p2){
  return sqrt(pow(p1.y-p2.y,2)+pow(p1.x-p2.x,2));
}