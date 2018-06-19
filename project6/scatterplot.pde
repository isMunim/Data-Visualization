
class Scatterplot extends Frame {

  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 20;
  boolean drawLabels = true;
  float spacer = 5;
  Table data;
  ArrayList <PVector> points = new ArrayList <PVector> ();
  
   Scatterplot( Table data, int idx0, int idx1 ){
     this.data = data;
     this.idx0 = idx0;
     this.idx1 = idx1;

     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));

     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));
   }

   void draw(){
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        //PVector p = points.get(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer, v0+border+spacer );

        stroke( 0 );
        strokeWeight(1);
        fill(0,255,0);
        if(selected.contains(i)|| selectedSP.contains(i)|| selectedSPLOM.contains(i) || selectedLine.contains(i) ){
          fill(255,0,0);
          ellipse( x,y,5,5 );
        }else{
          ellipse( x,y,3,3 );
        }
        points.add(new PVector(x, y, i));
     }
    
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      if (mouseX>= p.x-5 && mouseX <= p.x+5 && mouseY>= p.y-5 && mouseY <= p.y+5 ) {
        fill(255, 0, 0);
        ellipse( p.x, p.y, 5, 5 );
        
        selectedSP.add((int)p.z);
        selected.add((int)p.z);
        selectedSPLOM.add((int)p.z);
        selectedLine.add((int)p.z);
        textAlign(LEFT);
        
       
      }
    }
     stroke(200);
     noFill();
     rect( u0+border,v0+border, w-2*border, h-2*border);

     if( drawLabels ){
       fill(255);
       textAlign( LEFT );
       text( table.getColumnTitle(idx0), u0+15, v0+15 );
       pushMatrix();
      
       translate( u0+5, v0+5 );
       rotate( PI/2 );
       textAlign( LEFT );
       text( table.getColumnTitle(idx1), 0, 0 );
       popMatrix();
     }
}
  void drawGrid() {  //TODO
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
        line(buffer, (h-6-(i*diffY)), w, (h-6-(i*diffY)) );
      }
      int diffX = (494)/10;
      for (int i=0; i<=10; i++) {
        //ten vertical lines
        stroke(200, 100);
        line((buffer+6+(i*diffX)), buffer+6, (buffer+6+(i*diffX)), h-6 );
        //labels for ten lines
        textAlign(LEFT);
        text((nf(((minX)+(i*incrementX)), 0, 2)), (buffer-6+(i*diffX)), h-15);
      }
    }
}