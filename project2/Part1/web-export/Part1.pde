//Global Variables
frame myFrame = null;
frame myFrame2 = null;
PFont myFont;
String dataFile;
Table data;

int[] column0 ={};
float [] column1 ={};
float [] column2 ={};
String[] column3 ={};
String[] header ={};

String graphHeader = "";
String graphX = "";

int toggle =0;
int totalCols =2;
float adjY=0.0;
int buffer = 50;
int marginX = 150;
int marginY = 50;
int graphHeight;
float minBar, maxBar;
int maxOverall, minOverall;

void setup() {
  selectInput("Select a file to process:", "fileSelected");
  size(800, 600);  
  background( 100 );

  myFont = createFont("Georgia", 32);

  myFrame  = new barChart();
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
    processBarChart();
    getHeader();
  }
}

void getHeader(){
  String [] rawData = loadStrings(dataFile);
  for(int i =0; i<1; i++){
    header = split(rawData[i], ",");
    //printArray(header); 
  }
  graphHeader = header[2] + " vs " + header[0];
  graphX = header[0];
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

void processBarChart(){

  minBar = min(column2);
  maxBar = max(column2);
  maxOverall = floor(maxBar);
  minOverall =0; //Because bar charts better start at 0.

}
void draw() {


  if( myFrame != null ){
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


class barChart extends frame {


  void draw() {
    background(20);
    fill(200);
    stroke(255);
    println(toggle);
    for (int i=0; i<column2.length; i++) {
      int multiplier = 5;
      processBarChart();
      
      if(toggle == 0){
         adjY = map(column1[i], minOverall, maxOverall, 0, 100);
      }
      if(toggle == 1){
         adjY = map(column2[i], minOverall, maxOverall, 0, 100);
      }
      //if(toggle == 2){
      //  float adjY = map(column3[i], minOverall, maxOverall, 0, 100);
      //}
      
      float rectWidth = (width-marginX-marginY)/column2.length;
      float ypos = (height-marginY-marginY) - (adjY*multiplier);
      
      if(column3[i]=="DEM"){
        fill(0,0,255,120);
      }else if (column3[i]=="REP"){
        fill(255,0,0,120);
      }
      rect(rectWidth*i+buffer, ypos+buffer, rectWidth, adjY*multiplier ); //the bars
      textAlign(LEFT);
      
      if(rectWidth>30){
        text(column0[i], rectWidth*i+buffer+20, height-buffer+20); //Text labels of x-axis
        text(column2[i], rectWidth*i+buffer, ypos+buffer-10); //Text labels of each bar
      }
      drawEmbellishment();
    }
  }
  void drawEmbellishment() {
    // stroke(200,100);
    textAlign(LEFT);
    text(int(maxOverall), 5, buffer); //text label of max range
    text(int(maxOverall/2), 5, (height)/2); //text label of range/2
    text(int(minOverall), 5, height-buffer); //text label of starting value//
    stroke(255);
    line(buffer-3, height/2, width-marginX+3, height/2);
    line(buffer-3, height-buffer, width-marginX+3, height-buffer);
    line(buffer-3, buffer, width-marginX+3, buffer);

    //String graphHeader = header[0] + " vs " + header[2];
    textAlign(CENTER, CENTER);
    text(graphHeader, width/2, 20);
    text(graphX, width/2, height-10);

  }
  void mouseClicked() {
    if(toggle == totalCols){
      toggle = -1;
    }
      toggle++;

  }
  
}
