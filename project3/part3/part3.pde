//Global Variables
frame myFrame = null;
frame myFrame2 = null;
PFont myFont;
String dataFile;
Table data;

int headerLoaded = 0;
int coords=0;
int numOfColumns;
int numOfRows;

float[] column0 ={};
float[] column1 ={};
float[] column2 ={};
float[] column3 ={};
String[] header ={};

int bufferY = 30; //buffer between screen bezel and visualization
int bufferX = 100;
int graphHeight, graphWidth, canvasX1, canvasY1, plotMatrixHeight, plotMatrixWidth;

//PVector[] points; 
//Using array list to make PVectors a dynamic list!
ArrayList <PVector> points = new ArrayList <PVector> ();


float[] maxColumn=new float[4];
float[] minColumn=new float[4];

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  size(800, 600);  
  background( 100 );
  myFont = createFont("Georgia", 32);
  myFrame  = new scatterPlotMatrix();
  
  
}

/**** 
 * Computs the bounds of our graph, margins and the useable canvas
 *
 * TODO better handle the subtraction of 2 pixels
 ****/
void computeGraphBounds(){
  //Geting the height and width of our graphing area
  graphHeight = (height - bufferY) - bufferY;
  graphWidth = (width - bufferX) - bufferX;
  //Getting the height and width of our canvas
  canvasY1 = height-bufferY;
  canvasX1 = width-bufferX;
  //Computing width/height of each plot in matrix
  plotMatrixHeight = (graphHeight/4)-2;
  plotMatrixWidth = plotMatrixHeight;
}

/**** 
 * Loads the file and calls our needed functions
 *
 * TODO - none
 ****/
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    dataFile = selection.getAbsolutePath(); //Assigining dataFile a string CSV path
    data = loadTable(dataFile, "header"); //Loading csv data into our table
    readTable(data);
    computeGraphBounds();
    computeMinMaxAll();
    computePoints();
    getHeader();
  }
}

/**** 
 * Loads header of our data and stores in header[]
 *
 * TODO - add flag to stop call until header computed
 ****/
void getHeader() { 
  headerLoaded=1;
  String [] rawData = loadStrings(dataFile);
  for (int i =0; i<1; i++) {
    header = split(rawData[i], ",");
  }
}

/**** 
 * Computes minimum and maxium values for all columns
 *
 * DONE-------TODO create a for loop and array
 ****/
void computeMinMaxAll(){
  for(int i = 0; i<numOfColumns; i++){
    if(i==0){
      maxColumn[i] = (max(column0));
      minColumn[i] = (min(column0));
    }
    if(i==1){
      maxColumn[i] = (max(column1));
      minColumn[i] = (min(column1));
    }
    if(i==2){
      maxColumn[i] = (max(column2));
      minColumn[i] = (min(column2));
    }
    if(i==3){
      maxColumn[i] = (max(column3));
      minColumn[i] = (min(column3));
    }
  }
}

/**** 
 * Computes all the points
 *
 * TODO create a for loop to calculate
 *      current method inefficient
 ****/
void computePoints(){ 
  //computing for points of 00
  int yCol=0;
  int xCol=0;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (3*(plotMatrixHeight+2))-(map(column0[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (map(column0[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 01
  yCol=1;
  xCol=0;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (2*(plotMatrixHeight+2)) - (map(column1[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (map(column0[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 02
  yCol=2;
  xCol=0;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (1*(plotMatrixHeight+2)) - (map(column2[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (map(column0[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 03
  yCol=3;
  xCol=0;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (map(column3[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (map(column0[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 10
  yCol=0;
  xCol=1;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (3*(plotMatrixHeight+2)) - (map(column0[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX +(plotMatrixWidth+2) +(map(column1[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 11
  yCol=1;
  xCol=1;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (2*(plotMatrixHeight+2)) - (map(column1[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX +((plotMatrixWidth+2)) +(map(column1[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 12
  yCol=2;
  xCol=1;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (1*(plotMatrixHeight+2)) - (map(column2[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX +((plotMatrixWidth+2)) +(map(column1[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 13
  yCol=3;
  xCol=1;
  for (int i=0; i<column0.length; i++) {
    //With Lie factor
    float adjustedY = height - bufferY - (map(column3[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX +((plotMatrixWidth+2)) +(map(column1[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 20
  yCol=0;
  xCol=2;
  for (int i=0; i<column0.length; i++) {
    //With Lie factor
    float adjustedY = height - bufferY - (3*(plotMatrixHeight+2)) - (map(column0[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (2*(plotMatrixWidth+2)) +(map(column2[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 20
  yCol=1;
  xCol=2;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (2*(plotMatrixHeight+2)) - (map(column1[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (2*(plotMatrixWidth+2)) +(map(column2[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 22
  yCol=2;
  xCol=2;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (1*(plotMatrixHeight+2)) - (map(column2[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (2*(plotMatrixWidth+2)) +(map(column2[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 23
  yCol=3;
  xCol=2;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (map(column3[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (2*(plotMatrixWidth+2)) +(map(column2[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 30
  yCol=0;
  xCol=3;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (3*(plotMatrixHeight+2)) - (map(column0[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (3*(plotMatrixWidth+2)) +(map(column3[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 31
  yCol=1;
  xCol=3;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (2*(plotMatrixHeight+2)) - (map(column1[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (3*(plotMatrixWidth+2)) +(map(column3[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 32
  yCol=2;
  xCol=3;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (1*(plotMatrixHeight+2)) - (map(column2[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (3*(plotMatrixWidth+2)) +(map(column3[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
  //computing for points of 33
  yCol=3;
  xCol=3;
  for (int i=0; i<column0.length; i++) {
    float adjustedY = height - bufferY - (map(column3[i], minColumn[yCol], maxColumn[yCol], 0, plotMatrixHeight )); 
    float adjustedX = bufferX + (3*(plotMatrixWidth+2)) +(map(column3[i], minColumn[xCol], maxColumn[xCol], 0, plotMatrixWidth ));
    points.add(new PVector(adjustedX, adjustedY));
  }
}

/**** 
 * Reads a table with all our values from CSV
 *
 * DONE-------TODO get string and clean it before converting to float
 ****/
void readTable(Table data) {
  numOfColumns = data.getColumnCount();
  if(numOfColumns >4){
    numOfColumns=4;
  }
  numOfRows = data.getRowCount();
  for (TableRow row : data.rows()) {

    //Headers will change based on what's read...... Update this.
    String col0 = row.getString(0); //SATM
    String col1 = row.getString(1); //SATV
    String col2 = row.getString(2); //ACT
    String col3 = row.getString(3); //GPA

    //Stripping commas from data set in column0
    String[] list0 = split(col0, ',');
    col0 = join(list0, "");
    float col0int = 0.0;
    if (col0.equals("?") == false || col0.equals(null) == false ) {
      col0int = float(col0);
    }

    //Stripping commas from data set in column1
    String[] list1 = split(col1, ',');
    col1 = join(list1, "");
    float col1int = 0.0;
    //Handling null cases
    if (col1.equals("?") == false || col1.equals(null) == false ) {
      col1int = float(col1);
    }

    //Stripping commas from data set in column2
    String[] list2 = split(col2, ',');
    col2 = join(list2, "");
    float col2int=0.0;
    //Handling null cases
    if (col2.equals("?") == false || col2.equals(null) == false) {
      col2int = float(col2);
    }
    
    //Stripping commas from data set in column3
    String[] list3 = split(col3, ',');
    col3 = join(list3, "");
    float col3int=0.0;
    //Handling null cases
    if (col3.equals("?") == false || col3.equals(null) == false) {
      col3int = float(col3);
    }

    //Appending to our lists...
    column0 = append(column0, col0int);
    column1 = append(column1, col1int);
    column2 = append(column2, col2int);
    column3 = append(column3, col3int);
  }
}

void draw() {
 
  background(20);
  fill(200);
  stroke(255);
  if ( myFrame != null ) {
    myFrame.setPosition( 0, 0, width, height );
    myFrame.draw();
  }
}



abstract class frame {

  int u0, v0, w, h;
  void setPosition( int u0, int v0, int w, int h ) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }

  abstract void draw();
}