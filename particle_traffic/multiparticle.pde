class multiparticle{
  int NROWS=5;int NCOLS=10;
  float SPACE_ROW=30,SPACE_COL=30;
  particle[][] traffic=new particle[NCOLS][NROWS];
   
  multiparticle(PVector i_boundary){
    randomSeed(0);
    int[] pauseRIndices={int(random(NROWS)),int(random(NROWS)),int(random(NROWS))};
    int[] pauseCIndices={int(random(NCOLS)),int(random(NCOLS)),int(random(NCOLS))};
    println(pauseRIndices);
    println(pauseCIndices);
    for(int rIndex=0;rIndex<NROWS;++rIndex){
      for(int cIndex=0;cIndex<NCOLS;++cIndex){
        float posX=20+SPACE_COL*cIndex,posY=20+SPACE_ROW*rIndex;
        int pauseAt=0;
        for(int i=0;i<3;++i){
          if(rIndex==pauseRIndices[i] && cIndex==pauseCIndices[i]){
            pauseAt=10;
            break;
          }
        }
        traffic[cIndex][rIndex]=new particle(new PVector(posX,posY),i_boundary,pauseAt);
      }
    }
    
  }
  
  void show(int i_systemClock){
    for(int rIndex=0;rIndex<NROWS;++rIndex){
      for(int cIndex=0;cIndex<NCOLS;++cIndex){
        traffic[cIndex][rIndex].show();
        traffic[cIndex][rIndex].move(i_systemClock);
      }
    }
  }
}