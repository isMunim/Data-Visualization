//Global Variables
frame myFrame = null;
frame myFrame2 = null;
PFont myFont;
String dataFile;
Table data;

int[] column0 ={};
float[] column1 ={};
float[] column2 ={};
String[] column3 ={};
String[] header ={};

String graphHeader = "";
String graphX = "";

int buffer = 50; //buffer between screen bezel and visualization
int graphHeight;
int xBars;

float minLine, maxLine, maxOverall;
float minOverall = 0.0;
//PVector[] points; 
//Using array list to make PVectors a dynamic list!
ArrayList <PVector> points = new ArrayList <PVector> ();

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  //delay(1000);
  size(600, 600);  
  background( 100 );
  myFont = createFont("Georgia", 32);
  //processLineChart();
  myFrame  = new lineChart();
  //myFrame2 = new dotFrame();
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
  graphHeader = header[1] + " vs " + header[0];
  graphX = header[0];
}

void processLineChart() {
  graphHeight = (height - buffer) - buffer;


  xBars = (width - buffer - buffer)/ (column0.length - 1);

  minLine = min(column1);
  maxLine = max(column1);

  for (int i=0; i<column1.length; i++) {
    //float adjustedY = map(column1[i], minLine, maxLine, 0, graphHeight);
    //if(minLine < 6){
    //  minLine=0;
    //}if(maxLine <= 10){
    //  maxLine=10;
    //}
    float adjustedY = map(column1[i], minOverall, maxLine, 0, graphHeight); //from 0 to 10...
    float yPosition = height - buffer - adjustedY;
    float xPosition = buffer + (xBars *i);
    points.add(new PVector(xPosition, yPosition));
  }
}

void readTable(Table data) {
  for (TableRow row : data.rows()) {

    //Headers will change based on what's read...... Update this.
    String col0 = row.getString(0); //YEAR
    String col1 = row.getString(1); //VALUE0
    String col2 = row.getString(2); //VALUE1
    String col3 = row.getString(3); //VALUE2

    //Stripping commas from data set in column0
    String[] list0 = split(col0, ',');
    col0 = join(list0, "");
    int col0int;
    if (col0.equals("?") == true || col0.equals(null) == true ) {
      col0int = 0;
    } else {
      col0int = int(col0);
    }


    String[] list1 = split(col1, ',');
    col1 = join(list1, "");
    float col1int = 0.0;
    if (col1.equals("?") == true || col1.equals(null) == true ) {
      col1int = 0.0;
    } else {
      col1int = float(col1);
    }

    //Stripping commas from data set in column2
    String[] list = split(col2, ',');
    col2 = join(list, "");
    float col2int=0.0;
    if (col1.equals("?") == false || col1.equals(null) == false) {
      col2int = float(col2);
    }

    //Appending to our lists...
    column0 = append(column0, col0int);
    column1 = append(column1, col1int);
    column2 = append(column2, col2int);
    column3 = append(column3, col3);
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