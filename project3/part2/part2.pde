//Global Variables
frame myFrame = null;
frame myFrame2 = null;
PFont myFont;
String dataFile;
Table data;

float[] column0 ={};
float[] column1 ={};
float[] column2 ={};
float[] column3 ={};
String[] header ={};

String graphHeader = "";
String graphX = "";

int buffer = 30; //buffer between screen bezel and visualization
int bufferX = 100;

int graphHeight, graphWidth, canvasWidth, canvasHeight;
int xBars;

float minX, minY, maxX, maxY;
float minLine, maxLine, maxOverall;
int minOverall = 0;
//PVector[] points; 
//Using array list to make PVectors a dynamic list!
ArrayList <PVector> points = new ArrayList <PVector> ();

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  size(800, 600);  
  background( 100 );
  myFont = createFont("Georgia", 32);
  myFrame  = new scatterPlot();
  
  //Geting the height and width of our graphing area
  graphHeight = (height - buffer) - buffer;
  graphWidth = (width - buffer) - buffer;
  //Getting the height and width of our canvas
  canvasHeight = height-buffer;
  canvasWidth = width-buffer;
  
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    dataFile = selection.getAbsolutePath(); //Assigining dataFile a string CSV path
    data = loadTable(dataFile, "header"); //Loading csv data into our table
    readTable(data);
    processLineChart();
    getHeader();
  }
}

void getHeader() {
  String [] rawData = loadStrings(dataFile);
  for (int i =0; i<1; i++) {
    header = split(rawData[i], ",");
  }
  graphHeader = header[3] + " vs " + header[2];
  graphX = header[2];
}

void processLineChart() {
  xBars = (width - buffer - buffer)/ (column2.length - 1);

  /*  WILL BE DIFFERENT BASED ON WHAT WE ARE GRAPHING */
  minLine = (min(column3));
  maxLine = (max(column3));
  
  minY = (min(column3));
  maxY = (max(column3));
  
  minX = (min(column2));
  maxX = (max(column2));
   //Testing values
  println("MaxX = " +maxX);
  println("MinX = " +minX);
  println("MaxY = " +maxY);
  println("MinY = " +minY);
  

  //Create the PVectors!
  for (int i=0; i<column3.length; i++) {
    //No lie factor
    float adjustedY = map(column3[i], 0, maxY, 0, graphHeight );
    float adjustedX = map(column2[i],0,maxX,0,graphWidth);
    //With Lie factor
    //float adjustedY = map(column3[i], minY, maxY, 0, graphHeight ); //from 0 to 10...
    //float adjustedX = map(column2[i], minX, maxX, 0, graphWidth );
    
    float yPosition = height - buffer - adjustedY;
    //float xPosition = buffer + (xBars *i);
    float xPosition = buffer + adjustedX;
    points.add(new PVector(xPosition, yPosition));
  }
}

void readTable(Table data) {
  for (TableRow row : data.rows()) {

    //Headers will change based on what's read...... Update this.
    String col0 = row.getString(0); //SATM
    String col1 = row.getString(1); //SATV
    String col2 = row.getString(2); //ACT
    String col3 = row.getString(3); //GPA

    //Stripping commas from data set in column0
    String[] list0 = split(col0, ',');
    col0 = join(list0, "");
    float col0int;
    if (col0.equals("?") == true || col0.equals(null) == true ) {
      col0int = 0;
    } else {
      col0int = float(col0);
    }

    //Stripping commas from data set in column1
    String[] list1 = split(col1, ',');
    col1 = join(list1, "");
    float col1int = 0.0;
    //Handling null cases
    if (col1.equals("?") == true || col1.equals(null) == true ) {
      col1int = 0.0;
    } else {
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