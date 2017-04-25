int nCells=0,cellSize=0;
float startX=100,startY=0,cellGap=1;
boolean[][] cellStates;
boolean gameStatus=false;
  automata2d gameOfLife;
void setup(){
  size(1000,1000);
  background(200,200,0);
  frameRate(5);
  
  nCells=100;
  cellSize=6;
  gameOfLife=new automata2d(nCells);
//  cellStates=new boolean[nCells][nCells];
}

void draw(){
     if(gameStatus){
//        gameOfLife.toggleValueAt(i,ii);     
          gameOfLife.changeState();
     };

  for(int i=0;i<nCells;i++){ // row
     for(int ii=0;ii<nCells;ii++){ // col
     if(gameOfLife.getValueAt(i,ii)) fill(0,0,0);
     else fill(255,255,255);
       rect(startX+ii*(cellSize+cellGap),startY+i*(cellSize+cellGap),cellSize,cellSize);
     } 
  }
}

void mousePressed(){
  float mX=mouseX-startX,mY=mouseY-startY;
  float div=cellSize+cellGap;
  int rowNum=int(mX/div);int colNum=int(mY/div);
  gameOfLife.toggleValueAt(colNum,rowNum);
//  cellStates[rowNum][colNum]=!cellStates[rowNum][colNum];
  
}

void keyPressed(){
  if(key=='s') gameStatus=!gameStatus;
  
  if(key=='c' || key=='C')
    gameOfLife.clear();
    
  if(key=='r' || key=='R'){
   gameOfLife.randomize();
  }
  
  
  
}

class automata2d{
  int nCells;
  boolean[][] cellStates;
  
  automata2d(){}
  automata2d(int num){
    nCells=num;
    cellStates=new boolean[nCells][nCells];
  }
  
  boolean getValueAt(int row,int col) { return cellStates[row][col];};
  void setValueAt(int row,int col,boolean val){ cellStates[row][col]=val;}
  void toggleValueAt(int row,int col){cellStates[row][col]=!cellStates[row][col];}
  
  void changeState(){
    //first and last column
    for(int i=0;i<nCells;i++){
      cellStates[i][0]=false;
      cellStates[i][nCells-1]=false;
    }
    
    //first row
    for(int ii=1;ii<nCells-1;ii++){
      int nLive=int(cellStates[0][ii-1])+int(cellStates[0][ii+1]);
      nLive+=int(cellStates[1][ii-1])+int(cellStates[1][ii])+int(cellStates[1][ii+1]);

      if(cellStates[0][ii] && (nLive==2 || nLive==3)) cellStates[0][ii]=true;
      else if(!cellStates[0][ii] && nLive==3) cellStates[0][ii]=true;
      else cellStates[0][ii]=false;
    }

    //last row
    for(int ii=1;ii<nCells-1;ii++){
      int nLive=int(cellStates[nCells-2][ii-1])+int(cellStates[nCells-2][ii])+int(cellStates[nCells-2][ii+1]);
      nLive+=int(cellStates[nCells-1][ii-1])+int(cellStates[nCells-1][ii+1]);

      if(cellStates[nCells-1][ii] && (nLive==2 || nLive==3)) cellStates[nCells-1][ii]=true;
      else if(!cellStates[nCells-1][ii] && nLive==3) cellStates[nCells-1][ii]=true;
      else cellStates[nCells-1][ii]=false;
    }    
    
    // cells other than first and last column
    for(int i=1;i<nCells-1;i++){ //row
      for(int ii=1;ii<nCells-1;ii++){ // col
        int nLive=int(cellStates[i-1][ii-1])+int(cellStates[i-1][ii])+int(cellStates[i-1][ii+1]);
        nLive+=int(cellStates[i-1][ii-1])+int(cellStates[i-1][ii+1]);
        nLive+=int(cellStates[i+1][ii-1])+int(cellStates[i+1][ii])+int(cellStates[i+1][ii+1]);
        
        if(cellStates[i][ii] && (nLive==2 || nLive==3)) cellStates[i][ii]=true;
        else if(!cellStates[i][ii] && nLive==3) cellStates[i][ii]=true;
        else cellStates[i][ii]=false;
      }
    }

  }
  
  void clear(){
    for(int i=0;i<nCells;i++){
      for(int ii=0;ii<nCells;ii++){
        cellStates[i][ii]=false;
      }
    }
  }
  void randomize(){
    for(int i=0;i<nCells;i++){
      for(int ii=0;ii<nCells;ii++){
        if(random(1)<0.5) cellStates[i][ii]=false;
        else cellStates[i][ii]=true;
      }
    }  
  }
}