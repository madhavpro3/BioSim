class multiparticle{
  int NROWS=3;int NCOLS=10;
  float SPACE_ROW=30,SPACE_COL=30;
  particle[][] traffic=new particle[NCOLS][NROWS];
  
  multiparticle(PVector i_boundary){
    
    for(int rIndex=0;rIndex<NROWS;++rIndex){
      for(int cIndex=0;cIndex<NCOLS;++cIndex){
        int pauseAt=0;
        //if(rIndex==pauseRIndex && cIndex==pauseCIndex){
        //  pauseAt=3;
        //}
        traffic[cIndex][rIndex]=new particle(new PVector(20+SPACE_COL*cIndex,20+SPACE_ROW*rIndex),i_boundary,pauseAt);
      }
    }
    
  }
  
  void show(){
    for(int rIndex=0;rIndex<NROWS;++rIndex){
      for(int cIndex=0;cIndex<NCOLS;++cIndex){
        traffic[cIndex][rIndex].show();
        traffic[cIndex][rIndex].move(systemClock);
      }
    }
  }
}
