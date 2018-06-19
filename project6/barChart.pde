

class barChart extends Frame {
  float minBar, maxBar, minOverall, maxOverall;
  int colID;
  Table data;
  float rectw;
  int colSize;
  int currentBar;
  barChart( Table data, int colID ) {
    this.colID = colID;
    this.data = data;

  }
  void setPosition( int u0, int v0, int w, int h ) {
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
    selectedBar.clear();

    processBarChart();
    drawToggleMenu();
    drawEmbellishment();
    //drawing bars
    int counter=0;
    for (int i=0; i<colSize; i++) {
      
      processBarChart();
      float adjY = map(data.getFloatColumn(barToggle)[i], 0, maxBar, 0, (h-margin-margin-margin));
      if( selected.contains(i) ||  selectedSP.contains(i) || selectedSPLOM.contains(i) || selectedLine.contains(i)) {
        stroke(255);
        textAlign(LEFT, BOTTOM);
        fill(0,255,0);
        for(int z =0; z<data.getColumnCount(); z++){
          
          if(counter<1) text( data.getColumnTitle(z)+ ": "+ data.getStringColumn(z)[i], (2*width)/3+20+4+(5), height-136+55+(z*15) );
          
        }
        counter++;
        stroke(255,0,0); 
        fill(255,0,0);
      }else{
        fill(0,255,0);
        stroke(255);
      }
      rectw = (float)(w-margin-margin)/colSize;
      float yPos = (h-margin)-adjY;
      rect(rectw*i+margin+u0,yPos, rectw, adjY);
      
    }
    
    //If mouse hovering...

    if( (mouseX>(margin+u0)) && (mouseX<u0+w-(margin)) && (mouseY<(h-margin)) && (mouseY>margin)){
      fill(0,255,0);
      stroke(0,255,0);
      rectw = (float)(w-margin-margin)/colSize;
      float curBar = (mouseX-margin-u0)/rectw;
      currentBar = floor(curBar);
      selected.add(currentBar);
      selectedSP.add(currentBar);
      selectedSPLOM.add(currentBar);
      selectedLine.add(currentBar);
      selectedBar.add(currentBar);      
    }
    
      
    
  }

  void mousePressed() {

  }
  void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT){
      if (barToggle < (colCount)) {
        barToggle++;
        println(barToggle);
        
      }
    }else if (keyCode == LEFT){
      if(barToggle != 0){
        barToggle--;
        println(barToggle);
      }
    } 
  }
}
  void drawToggleMenu(){
    fill(255);
    textAlign(CENTER, CENTER);
    text("Press left and right keys to toggle between attributes!", w/2+u0, h-10);
  }
  void drawEmbellishment() {
    fill(255);
    textAlign(LEFT);
    text(nf(maxBar,0,0), u0-5, margin+margin); //text label of max range
    text(nf((maxBar/2),0,0), u0-5, (h+margin)/2); //text label of range/2
    text(int(0), 5+u0, h-margin); //text label of starting value//
    stroke(255);
    line(u0+margin-3, h/2, u0+w-margin+3, h/2);
    line(u0+margin-3, h-margin, u0+w-margin+3, h-margin);
    line(u0+margin-3, margin+margin, u0+w-margin+3, margin+margin);

    textAlign(CENTER, CENTER);
    text( table.getColumnTitle(barToggle), w/2+u0, 20 );
 
  }
}