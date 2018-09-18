class particle{
  int diameter=15;
  color c=color(200,0,0);
  PVector pos=new PVector(0,0);
  float speed=5;
  particle(PVector i_pos){
    pos=i_pos;
  };
  
  void move(PVector i_boundary){
    // Check if any other particle exists in the collision distance
    // from the matrix of particle positions
    
    if(pos.x > i_boundary.x){
      pos.x=0;
    }
    else if(pos.x < 0){
      pos.x=i_boundary.x;
    }
    else{
      pos.x=pos.x+speed;
    }
    if(pos.y > i_boundary.y){
      pos.y=0;
    }
    else if(pos.y < 0){
      pos.y=i_boundary.y;
    }
  }
  
  void show(){
    fill(c);
    noStroke();
    ellipse(pos.x,pos.y,diameter,diameter);
  }
}
