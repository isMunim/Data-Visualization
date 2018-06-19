

class barChart extends Frame {
  float minBar, maxBar, minOverall, maxOverall;
  int colID;
  Table data;
  float rectw;
  int colSize;
  barChart( Table data, int colID ) {
    this.colID = colID;
    this.data = data;

  }
  void setPosition( int u0, int v0, int w, int h ) {
    //println("u0 ="+u0 + "v0 ="+v0);
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  void processBarChart(){
    
    minBar = min(data.getFloatColumn(barToggle));
    maxBar = max(data.getFloatColumn(barToggle));
    
    colSize=data.getFloatColumn(barToggle).length;
  }
  void draw() {
    background(20);
    fill(200);
    stroke(255);

    drawToggleMenu();
    //drawing bars
    for (int i=0; i<colSize; i++) {
      processBarChart();
      float adjY = map(data.getFloatColumn(barToggle)[i], 0, maxBar, 0, (h-margin-margin));
      rectw = (float)(w-margin-margin)/colSize;
      float yPos = (h-margin)-adjY;
      rect(rectw*i+margin,yPos, rectw, adjY);
      drawEmbellishment();
    }
    //If mouse hovering...
    if( (mouseX>margin) && (mouseX<w-margin) && (mouseY<(h-margin)) && (mouseY>margin)){
      fill(0,255,0);
      stroke(0,255,0);
      rectw = (float)(w-margin-margin)/colSize;
      float curBar = (mouseX-margin)/rectw;
      int currentBar = floor(curBar);
      
      if(currentBar>=0 && currentBar<colSize){
        float adjY = map(data.getFloatColumn(barToggle)[currentBar], 0, maxBar, 0, (h-margin-margin));
        float yPos = (h-margin)-adjY;
        rect(rectw*currentBar+margin,yPos, rectw, adjY);
        int xPadding = 0;
        fill(255);
        if(currentBar < (0.5*colSize)){
          xPadding = w-margin-margin-100;
          line(mouseX,mouseY, 50+xPadding , h-margin-100);
        }else{
          line(mouseX,mouseY, 150+xPadding , h-margin-100);
        }
        rect(50+xPadding, h-100-margin,100,100);
        stroke(0,0,255);
        fill(0,0,255);
        textAlign(LEFT);
        text("Details:",52+xPadding,h-margin-88);
        for(int i =0; i<data.getColumnCount(); i++){
        //for(int i =0; i<colCount; i++){
          text( data.getColumnTitle(i)+ ": "+ data.getStringColumn(i)[currentBar], 52+xPadding, h-margin-(75-i*15) );
        }
        
      }
      
      
    }
  }

  void mousePressed() {
    if (barToggle == (colCount)) {
      barToggle = -1;
    }
    barToggle++;
    processBarChart();
  }
  void drawToggleMenu(){
    stroke(255);
    fill(200);
    textAlign(CENTER, CENTER);
    text("Click anywhere on the graph to toggle data", w/2, h-20);
    text("Hover over bars to see details", w/2, h-30);
  }
  void drawEmbellishment() {
    // stroke(200,100);
    textAlign(LEFT);
    text(int(maxBar), 5, margin); //text label of max range
    text(int(maxBar/2), 5, (h)/2); //text label of range/2
    text(int(0), 5, h-margin); //text label of starting value//
    stroke(255);
    line(margin-3, h/2, w-margin+3, h/2);
    line(margin-3, h-margin, w-margin+3, h-margin);
    line(margin-3, margin, w-margin+3, margin);

    textAlign(CENTER, CENTER);
    text( table.getColumnTitle(barToggle), w/2, 20 );
 
  }
}