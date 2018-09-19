class multiparticle{
  int NROWS=5;int NCOLS=10;
  float SPACE_ROW=30,SPACE_COL=30;
  particle[][] traffic=new particle[NCOLS][NROWS];
   
  multiparticle(PVector i_boundary){
    randomSeed(0);
    int[] pauseRIndices={int(random(NROWS)),int(random(NROWS)),int(random(NROWS))};
    int[] pauseCIndices={int(random(NCOLS)),int(random(NCOLS)),int(random(NCOLS))};

    for(int rIndex=0;rIndex<NROWS;++rIndex){
      for(int cIndex=0;cIndex<NCOLS;++cIndex){
        float posX=20+SPACE_COL*cIndex,posY=20+SPACE_ROW*rIndex;
        traffic[cIndex][rIndex]=new particle(new PVector(posX,posY),i_boundary);
      }
    }
    
    for(int i=0;i<3;++i){
      traffic[pauseCIndices[i]][pauseRIndices[i]].pauseMotionAt(3);
    }
  }
  
  void show(int i_systemClock){
    for(int rIndex=0;rIndex<NROWS;++rIndex){
      traffic[NCOLS-1][rIndex].move(i_systemClock);
      traffic[NCOLS-1][rIndex].show();
    }

    for(int rIndex=0;rIndex<NROWS;++rIndex){
      for(int cIndex=NCOLS-2;cIndex>=0;--cIndex){        
        PVector nextParticlePos=traffic[cIndex+1][rIndex].getPos();
        PVector curParticlePos=traffic[cIndex][rIndex].getPos();
        
        if( abs(nextParticlePos.x-curParticlePos.x) >= SPACE_COL){
          traffic[cIndex][rIndex].move(i_systemClock);
        }
        else{
          traffic[cIndex][rIndex].blocked();
        }
        traffic[cIndex][rIndex].show();
      }
    }
    
  }
}