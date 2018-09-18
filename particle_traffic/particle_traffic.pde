int NROWS=3;int NCOLS=10;
float SPACE_ROW=30,SPACE_COL=30;

particle[][] traffic=new particle[NCOLS][NROWS];
void setup(){
  size(500,500);

  for(int rIndex=0;rIndex<NROWS;++rIndex){
    for(int cIndex=0;cIndex<NCOLS;++cIndex){
      traffic[cIndex][rIndex]=new particle(new PVector(20+SPACE_COL*cIndex,20+SPACE_ROW*rIndex));
    }
  }
}

void draw(){
  background(255);

  for(int rIndex=0;rIndex<NROWS;++rIndex){
    for(int cIndex=0;cIndex<NCOLS;++cIndex){
      traffic[cIndex][rIndex].show();
      traffic[cIndex][rIndex].move(new PVector(width,height));
    }
  }
}