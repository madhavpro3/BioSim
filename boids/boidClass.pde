class boid{  
private  
  float bWidth=6,bLength=10;
  PVector[] vertices=new PVector[3];
  PShape skeleton=new PShape();
  color boidColor=color(0,0,0);
  float targetDirection=0;
public
  PVector position=new PVector(0,0);  
  float direction=0;; // in radians

  boid(){}
  boid(PVector pos,float dir){
    position=pos;
    direction=dir;
    targetDirection=dir;
  }
  
  void setPosition(PVector pos){
    position.x=pos.x;
    position.y=pos.y;
   // position=pos;
  }
  void move(){
    direction+=0.05*(targetDirection-direction);
    
    PVector prevPosition=position;
    position.x=prevPosition.x+cos(direction); 
    position.y=prevPosition.y+sin(direction);
    
    if(position.x > width) position.x=0;
    if(position.x < 0) position.x=width;

    if(position.y > height) position.y=0;
    if(position.y < 0) position.y=height;
    
  }
  void setDirection(float dir){
    //println("Prev dir "+ direction);
    //direction=dir;
    targetDirection=dir;
    //println("new Dire "+ dir);
  }
  PVector getPosition(){
    return position;
  }
  float getDirection(){
    return direction;
  }
  float getHLength(){
    return abs(bWidth*cos(0.5*PI - direction)) + abs(bLength*cos(direction));
  }
  float getVLength(){
    return abs(bWidth*sin(0.5*PI - direction)) + abs(bLength*sin(direction));
  }
  PVector getCenter(){
    int numVertices=vertices.length; //<>//
    float x=bLength/numVertices;
    float y=0;
    x+=position.x;
    y+=position.y;
    return new PVector(x,y);
  }
 //<>//
  boolean isColliding(boid b){
    PVector boid1Center=getCenter(); //<>//
    PVector boid2Center=b.getCenter();
    float distBetweenBoids=sqrt(pow(boid1Center.x-boid2Center.x,2)+pow(boid1Center.y-boid2Center.y,2));
    //println(boid1Center.x+","+boid2Center.x + ": "+boid1Center.y+","+boid2Center.y); //<>//

    //if(distBetweenBoids < 20){
    //  setFillColor(color(255,0,0));
    //  b.setFillColor(color(255,0,0));
    //}
    //else{
    //  setFillColor(color(0,0,0));
    //  b.setFillColor(color(0,0,0));
    //}
    
    if(distBetweenBoids < 50){
      return true;
    }
    else{
      return false;
    }
    
    
    //if(abs(position.x-b.position.x) < 0.5*(getHLength()+b.getHLength() + 50) &&
    //  abs(position.y-b.position.y) < 0.5*(getVLength() + b.getVLength()) + 50){
    //  return true;
    //}
    
  }
  void setFillColor(color c){
    boidColor=c;
    show();
  }
  void show(){
    vertices[0]=new PVector(0,bWidth*0.5);
    vertices[1]=new PVector(0,-bWidth*0.5);
    vertices[2]=new PVector(bLength,0);

    pushMatrix();
    translate(position.x,position.y);
    rotate(direction);
     //<>//
    skeleton=createShape(TRIANGLE,vertices[0].x,vertices[0].y,vertices[1].x,vertices[1].y,vertices[2].x,vertices[2].y);
    skeleton.setFill(boidColor);
    noStroke();
    shape(skeleton);
    popMatrix();
  }
};