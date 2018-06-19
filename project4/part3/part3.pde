
Frame myFrame = null;
Table table;
int dvToggle=0;

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
   // myFrame = new Scatterplot(table, useColumns.get(0),useColumns.get(1)  );
  //  myFrame.drawLabels=true;
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