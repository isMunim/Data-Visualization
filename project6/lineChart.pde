

class lineChart extends Frame {
  float minY, maxY, minOverall, maxOverall;
  int colID;
  Table data;
  float rectWidth;
  int colSize;
  int buffer = 20;
  int xTicks;
  ArrayList <PVector> points = new ArrayList <PVector> ();
  
  lineChart( Table data, int colID ) {
    this.colID = colID;
    this.data = data;
  }
  

  
  void setPosition( int u0, int v0, int w, int h ) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  void processLineChart(){
    points.clear();
    minY = min(data.getFloatColumn(lineToggle));
    maxY = max(data.getFloatColumn(lineToggle));
    
    xTicks = (w-buffer-buffer)/data.getRowCount();
    colSize=data.getFloatColumn(lineToggle).length;
    
     for ( int i = 0; i < table.getRowCount(); i++ ) {
      TableRow r = table.getRow(i);

      float xPosition = u0+ buffer + (xTicks *i);
      float y = h-buffer-map( r.getFloat(lineToggle), 0, maxY, 0, h-buffer-buffer-buffer);
      points.add(new PVector(xPosition, y, i));

    }
    
  }
  void draw() {
    selectedLine.clear();
    stroke(255);

    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      noStroke();
      fill(0,255,0);
      ellipse( p.x, p.y, 4, 4);

    }
    drawEmbellishment();
    fill(255);
    textAlign(LEFT);
    text("Hover over a point to see details! ", width-200, h-550);
     
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      if (mouseX>= p.x-5 && mouseX <= p.x+5 && mouseY>= p.y-5 && mouseY <= p.y+5 || selected.contains((int)p.z) ||  selectedSP.contains((int)p.z) || selectedBar.contains((int)p.z) ){
        noStroke();
        fill(255, 0, 0);
        ellipse( p.x, p.y, 6, 6 );
        selected.add((int)p.z);
        selectedSP.add((int)p.z);
        selectedSPLOM.add((int)p.z);
        selectedLine.add((int)p.z);
      }
    }
      
      
    
  }

 void drawLines(){
 for (int i=0; i<points.size(); i++) {
      if(i<points.size()-1){
        stroke(200);
        line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
      }
    }
  
 }
  void drawEmbellishment() {
    fill(255);
    textAlign(LEFT);
    text(nf(maxY,0,0), u0, margin+buffer); //text label of max range
    text(nf(maxY/2,0,0), u0, (h+margin)/2); //text label of range/2
    text(int(0), u0+5, h-margin); //text label of starting value//
    stroke(255);
    line(u0+margin-3, h/2, u0+w-margin+3, h/2);
    line(u0+margin-3, h-margin, u0+w-margin+3, h-margin);
    line(u0+margin-3, margin+buffer, u0+w-margin+3, margin+buffer);

    textAlign(CENTER, CENTER);
    text( table.getColumnTitle(lineToggle), u0+w/2, 20 );
    text( "Press up and down keys to toggle between attributes!", u0+w/2, h-10 );
    drawLines();
    processLineChart();
  }

  void mousePressed() {

  }
  void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (lineToggle < (colCount)) {
        lineToggle++;
      }
      println(lineToggle);
    } else if (keyCode == DOWN) {
      if(lineToggle != 0){
        lineToggle--;
      }
      println(lineToggle);
    }else if (key == RIGHT){
      if (barToggle < (colCount)) {
        barToggle++;
        println(barToggle);
      }
    }else if (key == LEFT){
      if(barToggle != 0){
        barToggle--;
        println(barToggle);
      }
    }  
   } 
  }

}