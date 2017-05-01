//TODO
/*
  Avoid collision
*/

int numBoids=10;
float neighbourhoodRadius=100;
//boolean[] isBoidColliding=new boolean[numBoids];
boid[] boids=new boid[numBoids];

float[][] distanceMatrix=new float[numBoids][numBoids];
short[][] neighbourhoodMatrix=new short[numBoids][numBoids];
float[] boidNeighbourDir=new float[numBoids];
float[] boidCollisionAvoidanceDir=new float[numBoids];

void setup(){
  size(500,500);
  background(255);
  for(int i=0;i<numBoids;i++){
    boids[i]=new boid(new PVector(i*width/numBoids,i*height/numBoids),i*2*PI/numBoids);
//    isBoidColliding[i]=false;
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
        if(distanceMatrix[i][j]<neighbourhoodRadius){
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
    float avgDirOfNeighbours=0;
    int numNeighbours=0;
    for(int ii=0;ii<numBoids;ii++){
      avgDirOfNeighbours+=boids[ii].getDirection()*neighbourhoodMatrix[i][ii];
      numNeighbours+=neighbourhoodMatrix[i][ii];
    }
    
    avgDirOfNeighbours/=numNeighbours;
    boidNeighbourDir[i]=avgDirOfNeighbours;
  }
  
  for(int boidIndex=0;boidIndex<numBoids;boidIndex++){
    boidCollisionAvoidanceDir[boidIndex]=boids[boidIndex].getDirection();
  }
  
  //direction to avoid collision
  for(int i=0;i<numBoids;i++){
    for(int ii=i+1;ii<numBoids;ii++){
      if(boids[i].isColliding(boids[ii])){
        
        float dirBoid1TowardsBoid2=atan2(boids[ii].getPosition().y-boids[i].getPosition().y,boids[ii].getPosition().x-boids[i].getPosition().x);

        boidCollisionAvoidanceDir[i]=0.5*(boidCollisionAvoidanceDir[i]+dirBoid1TowardsBoid2+PI);
        boidCollisionAvoidanceDir[ii]=0.5*(boidCollisionAvoidanceDir[ii]+dirBoid1TowardsBoid2);
      }
    }
  }
  
  
  for(int i=0;i<numBoids;i++){
    boids[i].setDirection(0.5*(boidNeighbourDir[i]+boidCollisionAvoidanceDir[i]));
    boids[i].move();
    boids[i].show();
  }
 };

float vectorDirection(PVector p1,PVector p2){
  return atan2(p1.y-p2.y,p1.x-p2.x);
}
float distance(PVector p1,PVector p2){
  return sqrt(pow(p1.y-p2.y,2)+pow(p1.x-p2.x,2));
}