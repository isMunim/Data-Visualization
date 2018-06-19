
//float rectWidth;

class twoVis extends frame {


  void draw() {
    background(20);
    fill(200);
    stroke(235);
    
    //processBarChart();
    
    //Drawing line chart
    for (PVector p : points) {
      ellipse( p.x, p.y, 4, 4);
    }
    
    //Drawing Bar Chart
    stroke(255,100);
    fill(200,100);
    for (int i=0; i<column2.length; i++) {
      int multiplier = 5;
      float adjY = map(column2[i], minOverall, maxOverall, 0, 100);
      float rectWidth = (width-buffer-buffer)/column2.length;
      float ypos = (height-buffer-buffer) - (adjY*multiplier);
      
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
      //drawEmbellishmentBar();
    }
    drawEmbellishmentLine();
  }
  
  void drawEmbellishmentLine(){
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      stroke(200,100);
      //line(p.x, buffer, p.x, height-buffer);
      textAlign(LEFT);
      //text(column0[i], p.x -15 , height-buffer+20);
      //text(column1[i], p.x -15 , p.y-5);
      if(points.size() < 15){
      //text(column0[i], p.x -15 , height-buffer+20);
      text(column1[i], p.x -15 , p.y-15);
      }

      if(i>0){
        stroke(200);
        line(points.get(i).x, points.get(i).y, points.get(i-1).x, points.get(i-1).y);

      }
    }
    textAlign(LEFT);
    text(maxOverall,10,buffer);
    text(maxOverall/2,10,(height)/2);
    text(minOverall,10,height-buffer);
    stroke(200,100);
    line(buffer-3,height/2,width-buffer+3,height/2);
    line(buffer-3,height-buffer,width-buffer+3,height-buffer);
    line(buffer-3,buffer,width-buffer+3,buffer);
    //String graphHeader = header[0] + " vs " + header[1];
    textAlign(CENTER);
    text(graphHeader,width/2,20);
    text(graphX, width/2, height-10);
  }
}