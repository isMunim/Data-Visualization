
Frame myFrame = null;
Table table;

void setup() {
  size(800, 600);  
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );

    ArrayList<Integer> useColumns = new ArrayList<Integer>();
    for (int i = 0; i < table.getColumnCount(); i++) {
      if ( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ) {
        println( i + " - type float" );
        useColumns.add(i);
      } else {
        println( i + " - type string" );
      }
    }
    myFrame = new Splom( table, useColumns );
    //myFrame = new Scatterplot(table, useColumns.get(0),useColumns.get(1)  );
  }
}


void draw() {
  background( 255 );

  if ( table == null ) 
    return;

  if ( myFrame != null ) {
    myFrame.setPosition( 200, 0, width-200, height );
    myFrame.draw();
  }
}

void mousePressed() {
  myFrame.mousePressed();
}

abstract class Frame {

  int u0, v0, w, h;
  int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }

  abstract void draw();
  void mousePressed() {
  }

  boolean mouseInside() {
    return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY;
  }
}

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


class Splom extends Frame {

  ArrayList<Scatterplot> plots = new ArrayList<Scatterplot>( );
  ArrayList<Scatterplot> detailPlots = new ArrayList<Scatterplot>( );
  int colCount;
  Table data;
  float border = 20;
  int dvToggle=6;
  //float borderX = 

  Splom( Table data, ArrayList<Integer> useColumns ) {
    this.data = data;
    colCount = useColumns.size();
    for ( int j = 0; j < colCount-1; j++ ) {
      for ( int i = j+1; i < colCount; i++ ) {
        Scatterplot sp = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
        Scatterplot detailView = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
        plots.add(sp);
        detailPlots.add(detailView);
      }
    }


    //table.getColumnCount()
    //table.getColumnType(int column) != Table.STRING
    //table.getColumnTitle();
  }

  void setPosition( int u0, int v0, int w, int h ) {
    super.setPosition(u0, v0, w, h);

    int curPlot = 0;
    for ( int j = 0; j < colCount-1; j++ ) {
      for ( int i = j+1; i < colCount; i++ ) {
        Scatterplot detailView = detailPlots.get(curPlot);
        Scatterplot sp = plots.get(curPlot++);
        int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
        int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
        sp.setPosition( su0, sv0, ((int)(w-2*(border))/(colCount-1)), (int)(h-2*border)/(colCount-1) );
        sp.drawLabels = true;
        sp.border = 3;
        detailView.setPosition (50, 210, 350, 350);
        detailView.border = 3;
      }
    }
  }


  void draw() {
    background(20);
    fill(200);
    stroke(255);
    for ( Scatterplot s : plots ) {
      s.draw();
    }
    //rect(50,210, 350,350);
    text("Hint: Click on a plot to see in detail", 53,580);
    if(dvToggle != 6){
      text("Detail View", 53, 205);
    }
    if (dvToggle==0) {
      Scatterplot v = detailPlots.get(0);
      v.draw();
    } else if (dvToggle==1) {
      Scatterplot v = detailPlots.get(1);
      v.draw();
    } else if (dvToggle==2) {
      Scatterplot v = detailPlots.get(2);
      v.draw();
    } else if (dvToggle==3) {
      Scatterplot v = detailPlots.get(3);
      v.draw();
    } else if (dvToggle==4) {
      Scatterplot v = detailPlots.get(4);
      v.draw();
    } else if (dvToggle==5) {
      Scatterplot v = detailPlots.get(5);
      v.draw();
    }
  }


  void mousePressed() { 
    for ( Scatterplot sp : plots ) {
      if ( sp.mouseInside() ) {
        // do something!!! OKay ^-^
        //println(sp.idx0 + " " + sp.idx1);
        if (sp.idx0 == 0 && sp.idx1 == 1) {
          dvToggle=0;
        }
        if (sp.idx0 == 0 && sp.idx1 == 2) {
          dvToggle=1;
        }
        if (sp.idx0 == 0 && sp.idx1 == 3) {
          dvToggle=2;
        }
        if (sp.idx0 == 1 && sp.idx1 == 2) {
          dvToggle=3;
        }
        if (sp.idx0 == 1 && sp.idx1 == 3) {
          dvToggle=4;
        }
        if (sp.idx0 == 2 && sp.idx1 == 3) {
          dvToggle=5;
        }
      }
    }
  }
}
