
class Scatterplot extends Frame {

  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  Table data;
  ArrayList <PVector> points = new ArrayList <PVector> ();

  Scatterplot( Table data, int idx0, int idx1 ) {
    this.data = data;
    this.idx0 = idx0;
    this.idx1 = idx1;

    minX = min(data.getFloatColumn(idx0));
    maxX = max(data.getFloatColumn(idx0));

    minY = min(data.getFloatColumn(idx1));
    maxY = max(data.getFloatColumn(idx1));

    //table.getColumnTitle();  
    //table.getRowCount()
    //table.getRow()
    // row.getFloat();
  }

  void draw() {
    background(20);
    fill(200);
    stroke(255);
    for ( int i = 0; i < table.getRowCount(); i++ ) {
      TableRow r = table.getRow(i);

      float x = map( r.getFloat(idx0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
      float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer, v0+border+spacer );

      noStroke( );
      fill(0, 255, 0);

      ellipse( x, y, 3, 3 );
      points.add(new PVector(x, y));
    }

    fill(255);
    textAlign(LEFT);
    text("Hover over a point to see details! ", width-200, height-550);
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      if (mouseX>= p.x-5 && mouseX <= p.x+5 && mouseY>= p.y-5 && mouseY <= p.y+5 ) {
        fill(255, 0, 0);
        ellipse( p.x, p.y, 5, 5 );
        float xVal = map( p.x, u0+border+spacer, u0+w-border-spacer, minX, maxX );
        float yVal = map( p.y, v0+h-border-spacer, v0+border+spacer, minY, maxY );
        println(xVal + " y = " + yVal);

        textAlign(LEFT);
        fill(20);
        stroke(255);
        rect(width-150, height-215, 140, 100);
        fill(255);
        text("Details: ", width-145, height-200);
        text(table.getColumnTitle(idx0)+" :"+xVal, width-145, height - 185);
        text(table.getColumnTitle(idx1)+" :"+yVal, width-145, height - 170);
        line(mouseX, mouseY, width-150, height-215);
      }
    }
    stroke(255);
    noFill();
    rect( u0+border, v0+border, w-2*border, h-2*border);
    drawGrid();
    if ( drawLabels ) {
      //stroke(255);
      fill(255);
      text( table.getColumnTitle(idx0), u0+5, v0+15 );
      //text( table.getColumnTitle(idx0), u0+width/2, v0+height-10 );
      pushMatrix();
      //translate( u0+10, v0+height/2 );
      translate( u0+5, v0+20 );
      rotate( PI/2 );
      text( table.getColumnTitle(idx1), 0, 0 );
      popMatrix();
    }
  }


  void drawGrid() { 
    int buffer = 50;
    //Draws a 10x10 grid in our graph area.
    int diffY = (494)/10;
    float incrementX = ((maxX-minX)/10);
    float incrementY = ((maxY-minY)/10);
    for (int i=0; i <= 10; i++) {
      //Ten text labels  
      textAlign(LEFT);
      text((nf(((minY)+(i*incrementY)), 0, 2)), 10, (550-6-(i*diffY)));
      //text label lines
      stroke(200, 100);
      line(buffer, (550-6-(i*diffY)), 550, (550-6-(i*diffY)) );
    }
    int diffX = (494)/10;
    for (int i=0; i<=10; i++) {
      //ten vertical lines
      stroke(200, 100);
      line((buffer+6+(i*diffX)), buffer+6, (buffer+6+(i*diffX)), 550-6 );
      //labels for ten lines
      textAlign(LEFT);
      text((nf(((minX)+(i*incrementX)), 0, 2)), (buffer-6+(i*diffX)), height-15);
    }
  }
}