

class polarCoords extends Frame {
  float minY, maxY, minOverall, maxOverall;
  float distX;
  int colID;
  Table data;
  float rectWidth;
  int colSize;
  int buffer = 25;
  int xTicks;
  int canvasHeight = height-margin-margin;
  int rowCount = table.getRowCount();
  int flag = 0;
  int numDisplay = rowCount;
  //ArrayList <PVector> points = new ArrayList <PVector> ();
  PVector[][]positions;
  
  float minima[] = new float[colCount];
  float maxima[] = new float[colCount];
  polarCoords( Table data ) {
    this.data = data;
    
  }
  
  void processMinMax(){
    for(int i=0; i<colCount; i++){
      minima[i] = min(data.getFloatColumn(i));
      maxima[i] = max(data.getFloatColumn(i));
      //println("minima["+i+"] ="+ minima[i]);
      //println("maxima["+i+"] ="+ maxima[i]);
    }
  }
  
  void processPolar(){
    //points.clear();
    positions = new PVector[colCount][rowCount];
    distX = (width-margin-margin)/colCount;
    //println("n of cols"+colCount);
    for (int col=0; col<colCount; col++){
     //println("current col"+col);
      for ( int i = 0; i < table.getRowCount(); i++ ) {
        TableRow r = table.getRow(i);
        float xPos = buffer + distX*col;
        //println("val>" +r.getFloat(0)+" min>"+ minima[col]+"max>" +maxima[col]);
        if(toggle>-1){
          float yPos = (height - buffer) - map(r.getFloat(col), minima[col], maxima[col], 0, canvasHeight);
          //points.add(new PVector(xPos, yPos, col));
          positions[col][i] = new PVector(xPos,yPos);
        }
        
      }
    }
    flag=1;
  }
  

  void draw() {
    background(20);
    fill(200);
    stroke(255);
    drawToggleMenu();
    if(flag==1){
      //drawToggleMenu();
      for(int row=0; row<numDisplay; row++){
       for(int col=0; col<colCount; col++){
         ellipse(positions[col][row].x, positions[col][row].y,3,3);
       }
      }
      
      drawLines();
      drawEmbellishment();
      for(int row=0; row<numDisplay; row++){
       for(int col=0; col<colCount; col++){
         if (mouseX>= positions[col][row].x-5 && mouseX <= positions[col][row].x+5 && mouseY>= positions[col][row].y-3 && mouseY <= positions[col][row].y+3 ) {
           drawHover(col,row); 
          
         }
      }
      }
      
      
    }

          
    
  }

  void drawHover(int col,int row){
    //println("col >" +col+ "row >"+row);
   fill(255, 0, 0);
   ellipse( positions[col][row].x, positions[col][row].y, 5, 5 );
   for(int c=0; c<colCount;c++){
     stroke(255,0,0);
     if(c<colCount-1){
       line(positions[c][row].x, positions[c][row].y, positions[c+1][row].x, positions[c+1][row].y );
     }
     ellipse( positions[c][row].x, positions[c][row].y, 5, 5 );
     textSize(14);
     stroke(255);
     text(data.getColumnTitle(c)+": "+data.getFloat(row,c), width-margin-50, margin+200+c*15) ;
   }
   
  }
  
  void drawToggleMenu(){
    stroke(255,255,255);
    //fill(255,255,255);
    textAlign(RIGHT, RIGHT);
    textSize(12);
    text("Click to load/swap graph", width-margin, margin);
    text("Hover over point to see details", width-margin, margin+15);
  } 
 void drawLines(){
   for(int row=0; row<numDisplay; row++){
     for(int col=0; col<colCount-1; col++){
       stroke(200);
       line(positions[col][row].x, positions[col][row].y, positions[col+1][row].x, positions[col+1][row].y );
     }
   } 
 }
  void drawEmbellishment() {
    for(int col=0; col<colCount; col++){
      stroke(255,255,255,40);
      line(margin+(col*distX), margin-2, margin+(col*distX), height-margin+2);
      textAlign(LEFT, LEFT);
      text(data.getColumnTitle(col), margin+(col*distX), height-margin/2 );
    }
    float dist=canvasHeight/10;
    float jumps=(maxima[0]-minima[0])/10;
    float jumps1=(maxima[colCount-1]-minima[colCount-1])/10;
    for(int i=0; i<11;i++){
      line(margin-2, height-margin-dist*i, width-margin-distX+2,  height-margin-dist*i);
      textAlign(LEFT,LEFT);
      textSize(8);
      text(nf((minima[0]+(jumps*i)),1,1),margin-20, height-margin-dist*i );
      text(nf((minima[colCount-1]+(jumps1*i)),1,1),width-margin-distX+2, height-margin-dist*i );
    }
    textAlign(RIGHT, RIGHT);
    text(nf((minima[1]),1,1),margin+distX,height-margin+10);
    text(nf((minima[2]),1,1),margin+2*distX,height-margin+10);
    text(nf((maxima[1]),1,1),margin+distX,margin-10);
    text(nf((maxima[2]),1,1),margin+2*distX,margin-10);
  }
  
  void mousePressed() {
    if (toggle == (colCount-1)) {
      toggle = -1;
    }
    toggle++;
    println("Toggle Val: "+toggle);
    swap();
    processMinMax();     //Processing minima's and maximas
    processPolar();
  }
 void swap(){
   data.addColumn(data.getColumnTitle(0)); //add a new column
   for(int i=0; i<rowCount; i++){
     data.setFloat(i,colCount, data.getFloat(i,0)); //copy values of first column to new column
   }
   data.removeColumn(0); //delete first column
 }
}