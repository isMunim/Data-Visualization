

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