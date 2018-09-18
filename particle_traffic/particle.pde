class particle{
  int diameter=15;
  color c=color(200,0,0);
  PVector pos=new PVector(0,0);
  float speed=5;
  PVector winBoundary=new PVector(0,0);
  int pauseAt=0;int pausetime=10;
  //boolean isStop=false;
  particle(PVector i_pos,PVector i_boundary,int i_pauseAt){
    pos=i_pos;
    winBoundary=i_boundary;
    pauseAt=i_pauseAt;
    if(pauseAt==0){
      pausetime=0;
    }
  };
  void move(int i_systemClock){
    // Check if any other particle exists in the collision distance
    // from the matrix of particle positions
    if(i_systemClock>=pauseAt && i_systemClock<=pauseAt+pausetime){
      return;    
    }
    if(pos.x > winBoundary.x){
      pos.x=0;
    }
    else if(pos.x < 0){
      pos.x=winBoundary.x;
    }
    else{
      pos.x=pos.x+speed;
    }
    if(pos.y > winBoundary.y){
      pos.y=0;
    }
    else if(pos.y < 0){
      pos.y=winBoundary.y;
    }
  }
  
  void show(){
    if(pausetime>0){
      fill(color(150,150,0));
    }
    else{
      fill(c);
    }
    noStroke();
    ellipse(pos.x,pos.y,diameter,diameter);
  }
}