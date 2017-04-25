int numCells=100;
float cellSize=8;
float cellGap=0.5;
int startX=0,startY=0;

float ru=0.082,rv=0.041;
float dx=1,dy=1,dt=1;

spatialParam k=new spatialParam(numCells);
spatialParam f=new spatialParam(numCells);
chemical u=new chemical(numCells);
chemical v=new chemical(numCells);

void setup(){
  size(1000,1000);
  frameRate(4);
  
  //spatially varying params
  float minK=0.03,maxK=0.07;
  for(int iX=0;iX<numCells;iX++){
    float paramVal=minK+ iX*(maxK-minK)/numCells;
    k.setVal(paramVal,iX);
  }
  
  float minf=0,maxf=0.08;
  for(int iY=0;iY<numCells;iY++){
    float paramVal=minf+ iY*(maxf-minf)/numCells;
    f.setVal(paramVal,iY);
  }
  
  for(int iX=0;iX<numCells;iX++){
    for(int iY=0;iY<numCells;iY++){
      u.setVal(1,iX,iY);
      v.setVal(0,iX,iY);
    }
  }
}
void draw(){
  background(150);
  
  for(int iX=0;iX<numCells;iX++){
    for(int iY=0;iY<numCells;iY++){
       // grey color value
       float[] minMaxVals=v.getMinMaxVals();
       float grayValue=map(v.getVal(iX,iY),minMaxVals[0],minMaxVals[1],0,255);
       fill(grayValue);
       rect(startX+iX*(cellSize+cellGap),startY+iY*(cellSize+cellGap),cellSize,cellSize);
    }
  }
  
  v=evolveSystem(v);
  
}

chemical evolveSystem(chemical u){
  chemical uNew=new chemical(numCells);
  
  for(int index=0;index<numCells;index++){
    uNew.setVal(0,0,index);
    uNew.setVal(0,index,0);
  }
  
  for(int iX=1;iX<numCells-2;iX++){
    for(int iY=1;iY<numCells-2;iY++){
      float newValU=u.getVal(iX,iY)*(1-pow(v.getVal(iX,iY),2));
      newValU+=f.getVal(iY)*(1-u.getVal(iX,iY));
      newValU+=ru*(u.getVal(iX+2,iY)+u.getVal(iX,iY)-2*u.getVal(iX+1,iY));
      newValU+=ru*(u.getVal(iX,iY+2)+u.getVal(iX,iY)-2*u.getVal(iX,iY+1));
      uNew.setVal(newValU,iX,iY);      
    }
  }
  
  for(int index=0;index<numCells;index++){
    uNew.setVal(uNew.getVal(0,index),numCells-1,index);
    uNew.setVal(uNew.getVal(index,0),index,numCells-1);
  }
  
  return uNew;
}

class chemical{
  private
    int numCells;
    float[][] cellConcentrations=new float[numCells][numCells];
  public
    
    chemical(){}
    
    chemical(int nCells){
      numCells=nCells;
      cellConcentrations=new float[numCells][numCells];
    }
    
    float getVal(int indexX,int indexY){
      return cellConcentrations[indexX][indexY];
    }
    
    void setVal(float val,int indexX,int indexY){
      cellConcentrations[indexX][indexY]=val;
    }
    
    int getNumCells(){
      return numCells;
    }
    
    float[] getMinMaxVals(){
      float[] boundingVals={0,0};
      for(int indexX=0;indexX<numCells;indexX++){
        for(int indexY=0;indexY<numCells;indexY++){
          if(this.getVal(indexX,indexY) < boundingVals[0])
            boundingVals[0]=getVal(indexX,indexY);

          if(this.getVal(indexX,indexY)>boundingVals[1])
            boundingVals[1]=getVal(indexX,indexY);
          
        }
      }
      
      return boundingVals;
    }
}

class spatialParam{
  private
    int numCells=0;
    float[] paramVals;
 public
   
   spatialParam(){}
   
   spatialParam(int nCells){
     numCells=nCells;
     paramVals=new float[numCells];
   }
   
   float getVal(int index){
     return paramVals[index];
   }
   
   void setVal(float val,int index){
     paramVals[index]=val;
   }
}