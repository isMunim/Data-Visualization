
class Scatterplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  
   Scatterplot( Table data, int idx0, int idx1 ){
     
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
   
   void draw(){
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer, v0+border+spacer );
        
        noStroke( );
        fill(0,255,0);
        
        ellipse( x,y,3,3 );
     }
     
     stroke(255);
     noFill();
     rect( u0+border,v0+border, w-2*border, h-2*border);
     
     if( drawLabels ){
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
  
}