

class lineChart extends Frame {
  float minY, maxY, minOverall, maxOverall;
  int colID;
  Table data;
  float rectWidth;
  int colSize;
  int buffer = 50;
  int xTicks;
  ArrayList <PVector> points = new ArrayList <PVector> ();
  
  lineChart( Table data, int colID ) {
    this.colID = colID;
    this.data = data;
    
    

  }
  void processLineChart(){
    points.clear();
    minY = min(data.getFloatColumn(barToggle));
    maxY = max(data.getFloatColumn(barToggle));
    
    xTicks = (width-buffer-buffer)/data.getRowCount();
    colSize=data.getFloatColumn(barToggle).length;
    
       for ( int i = 0; i < table.getRowCount(); i++ ) {
      TableRow r = table.getRow(i);

      //float x = map( r.getFloat(idx0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
      float xPosition = buffer + (xTicks *i);
      float y = height-buffer-map( r.getFloat(barToggle), 0, maxY, 0, height-buffer-buffer);
      points.add(new PVector(xPosition, y));
      //noStroke( );
      //fill(0, 255, 0);

//      ellipse( xPosition, y, 3, 3 );
      //points.add(new PVector(xPosition, y));
    }
    
  }
  void draw() {
    background(20);
    fill(200);
    stroke(255);

    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      ellipse( p.x, p.y, 4, 4);

    }
    drawToggleMenu();
    drawEmbellishment();
    fill(255);
    textAlign(LEFT);
    //text("Hover over a point to see details! ", width-200, height-550);
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      if (mouseX>= p.x-5 && mouseX <= p.x+5 && mouseY>= p.y-5 && mouseY <= p.y+5 ) {
        fill(255, 0, 0);
        ellipse( p.x, p.y, 5, 5 );
      float curPnt = (p.x-buffer)/xTicks;
      int currentPnt = floor(curPnt);
     // int xPadding = 50;
      int xPadding = 0;
        fill(255);
        if(currentPnt < (0.5*colSize)){
          xPadding = width-margin-margin-100;
          line(mouseX,mouseY, 50+xPadding , height-margin-100);
        }else{
          line(mouseX,mouseY, 150+xPadding , height-margin-100);
        }
        rect(50+xPadding, height-100-margin,100,100);
        stroke(0,0,255);
        fill(0,0,255);
        textAlign(LEFT);
      text("Details:",52+xPadding,height-margin-88);
        for(int j =0; j<data.getColumnCount(); j++){
        //for(int i =0; i<colCount; i++){
          text( data.getColumnTitle(j)+ ": "+ data.getStringColumn(j)[currentPnt], 52+xPadding, height-margin-(75-j*15) );
        }

      }
    }
      
      
    
  }

  void mousePressed() {
    if (barToggle == (colCount)) {
      barToggle = -1;
    }
    barToggle++;
    processLineChart();
  }
  void drawToggleMenu(){
    stroke(255);
    fill(200);
    textAlign(CENTER, CENTER);
    text("Click anywhere on the graph to toggle data", width/2, height-20);
    text("Hover over point to see details", width/2, height-30);
  }
 void drawLines(){
 for (int i=0; i<points.size(); i++) {
      //ellipse( p.x, p.y, 4, 4);
      //if(i<points.size()-1){
      //  stroke(200);
      //  line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);

      //}
      if(i<points.size()-1){
        stroke(200);
        line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
      }
    }
  
 }
  void drawEmbellishment() {
    // stroke(200,100);
    textAlign(LEFT);
    text(int(maxY), 5, margin); //text label of max range
    text(int(maxY/2), 5, (height)/2); //text label of range/2
    text(int(0), 5, height-margin); //text label of starting value//
    stroke(255);
    line(margin-3, height/2, width-margin+3, height/2);
    line(margin-3, height-margin, width-margin+3, height-margin);
    line(margin-3, margin, width-margin+3, margin);

    textAlign(CENTER, CENTER);
    text( table.getColumnTitle(barToggle), width/2, 20 );
    drawLines();
     
  }
}