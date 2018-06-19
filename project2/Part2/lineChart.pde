

class lineChart extends frame {


  void draw() {
    background(20);
    fill(200);
    stroke(255);

    for (PVector p : points) {
      ellipse( p.x, p.y, 4, 4);
    }
    drawEmbellishment();
  }
  
  void drawEmbellishment(){
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      stroke(200,100);
      line(p.x, buffer, p.x, height-buffer);
      textAlign(LEFT);
      if(points.size() < 15){
      text(column0[i], p.x -15 , height-buffer+20);
      text(column1[i], p.x -15 , p.y-15);
      }

      if(i>0){
        stroke(200);
        line(points.get(i).x, points.get(i).y, points.get(i-1).x, points.get(i-1).y);

      }
    }
    textAlign(LEFT);
    text(maxLine,5,buffer);
    text(((maxLine)/2),5,(height)/2);
    text(minOverall,5,height-buffer);
   
    stroke(200,100);
    line(buffer-3,height/2,width-buffer+3,height/2);
    line(buffer-3,height-buffer,width-buffer+3,height-buffer);
    line(buffer-3,buffer,width-buffer+3,buffer);

    textAlign(CENTER);
    text(graphHeader,width/2,20);
    text(graphX, width/2, height-10);
  }
}