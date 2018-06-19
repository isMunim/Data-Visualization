

class scatterPlotMatrix extends frame {


  void draw() {
    background(20);
    fill(200);
    //stroke(255);
    fill(0,255,0);
    noStroke();
    drawPoints();
   
    fill(200);
    drawGrid();
    if(headerLoaded ==1){ //Mkaing sure if the file has alredy been loaded #ROBUST
      drawText();
    }
    //Only for testing bounds
    //drawTestBox();
    
  }
  /**** plots all the points ****/
  void drawPoints(){ 
    for (PVector p : points) {
          ellipse( p.x, p.y, 2, 2);
    }
  }
  
  /**** draws a red box aruond our useable canvas ****/
  void drawTestBox(){ 
    stroke(255,0,0);
    noFill();
    rect(bufferX,bufferY,canvasX1-bufferX,canvasY1-bufferY);
  }
  
  /**** Draws a grid of squares for our scatter matrix ****/
  void drawGrid(){ 
    stroke(255);
    noFill();
    for(int j=0;j<numOfColumns;j++){
      for(int i=0;i<numOfColumns;i++){
        rect(bufferX+(j*(plotMatrixWidth+2)),bufferY+(i*(plotMatrixHeight+2)),plotMatrixWidth+2,plotMatrixHeight+2);       
      }
    }
  }
  
  /**** Adds the text labels for our matrix ****/
  void drawText(){ 
   textAlign(CENTER);
   for(int i=0;i<4;i++){
     text(header[i],(bufferX+(i*plotMatrixWidth)+(plotMatrixWidth/2)),bufferY-5);
     text(header[i],(bufferX-50),(bufferY+(i*plotMatrixHeight)+(plotMatrixHeight/2)));
   }
  }
 
}