import java.util.*;
import static javax.swing.JOptionPane.*;

Frame myFrame = null;
Frame myFrame2 = null;
Frame myFrame3 = null;
Frame myFrame4 = null;

Table table;
int margin = 20;
int lineToggle=0;
int colCount=0;
int barToggle=0;
int splomSize;
int dvToggle=0;

HashSet<Integer> selected = new HashSet<Integer>();
HashSet<Integer> selectedSP = new HashSet<Integer>();
HashSet<Integer> selectedSPLOM = new HashSet<Integer>();
HashSet<Integer> selectedLine = new HashSet<Integer>();
HashSet<Integer> selectedBar = new HashSet<Integer>();

String line1 = "Hello and Welcome to my dashboard...";
String line2 = "\nPlease read the instruction carefully.";
String line3 = "\n\n-> Select scatterplot by clicling on diferent plots in the matrix.";
String line4 = "\n-> Toggle attributes in Bar Chart with left/right keys.";
String line5 = "\n-> Toggle attributes in Line Chart with up/down keys.";
String line6 = "\n-> You can select and drag an axis in the Parallel Coordinate Plane(PCP) to change it";
String line7 = "\n-> Selecting/Clicking on an axis on the PCP also shows it on the Line and Bar charts";
String line8 = "\n-> Hover over any single point to see its details.";
String line9 = "\n\nClick on the green controls box at any time to reload this message";

String msg = line1+line2+line3+line4+line5+line6+line7+line8+line9;
void setup(){
  size(1200,800);
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
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
    colCount = useColumns.size()-1;
    myFrame = new PCP( table, useColumns );
    myFrame2 = new Splom(table, useColumns);
    myFrame3 = new lineChart(table, useColumns.get(lineToggle));
    myFrame4 = new barChart(table, useColumns.get(barToggle));
  }
  showMessageDialog(null, msg); 
}


void draw(){
  
  background( 255 );
  if( table == null )
    return;
  if( myFrame != null ){
       
       myFrame.setPosition( 0, height/2, (2*width)/3, height/2 );
       myFrame.draw();
       selectedSP.clear();
  }
  if(myFrame2 != null){
      myFrame2.setPosition((2*width)/3, height/2, width/3, height/2);
      myFrame2.draw();
  } 
  
  if(myFrame3 != null){
      myFrame3.setPosition((1*width)/3, 0, (width)/3, height/2);
      myFrame3.draw();
  } 
  if(myFrame4 != null){
      myFrame4.setPosition((2*width)/3, 0, (width)/3, height/2);
      myFrame4.draw();
  } 
  
  drawControls();
  drawDetails();
}

void mousePressed(){
  myFrame.mousePressed();
  myFrame2.mousePressed();
  myFrame3.mousePressed();
  myFrame4.mousePressed();
  if(mouseX>(2*width)/3+20+2 && mouseX < ((2*width)/3+20+2)+115 && mouseY > height-256 && mouseY < height-256+115){
    showMessageDialog(null, msg);
  }
}

void mouseReleased(){
  myFrame.mouseReleased();
  myFrame2.mousePressed();
  myFrame3.mousePressed();
  myFrame4.mousePressed();
}

void keyPressed(){
  myFrame3.keyPressed();
  myFrame4.keyPressed();

}

void drawDetails(){
  noFill();
  stroke(255);
  rect((2*width)/3+20+2, height-136,238,115);
  
  stroke(255);
  textAlign(LEFT, BOTTOM);
  fill(0,255,0);
  text("Details:  (Only first shown!) ",(2*width)/3+20+5,height+20-136+2);
  text("(Hover over points to see details)",(2*width)/3+20+5,height+20-136+2+15);
  
}


void drawControls(){
  fill(0,255,0,230);
  rect((2*width)/3+20+2, height-256,115,115);
  fill(255);
  textAlign( CENTER);
  text("Controls:[CLICK ME]", ((2*width)/3)+20+5+56.5,height-256+15 );
  textAlign( LEFT,LEFT);
  text("Bar Toggle ->",((2*width)/3)+20+5,height-256+30 );
  for(int q=0; q<colCount+1; q++){
    if( q == barToggle){
      fill(255,0,0);
    } else {
      fill(255);
    }
    text(" "+q+" ",((2*width)/3)+50+(15*q),height-256+45 );
  }
  fill(255);
  text("Line Toggle ->",((2*width)/3)+20+5,height-256+60 );
  for(int q=0; q<colCount+1; q++){
    if( q == lineToggle){
      fill(255,0,0);
    } else {
      fill(255);
    }
    text(" "+q+" ",((2*width)/3)+50+(15*q),height-256+75 );
  }
  fill(255);
  text("Scatterplot ->",((2*width)/3)+20+5,height-256+90 );
  for(int q=0; q<splomSize; q++){
    if( q == dvToggle){
      fill(255,0,0);
    } else {
      fill(255);
    }
      text(" "+q+" ",((2*width)/3)+35+(15*q),height-256+105 );
    }

}
abstract class Frame {

  int u0,v0,w,h;
     int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }

  boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY;
   }
   
  abstract void draw();
  void mousePressed(){
    
  }
  void mouseReleased(){ }
  void keyPressed(){ }
  

   


}