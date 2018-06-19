

class scatterPlot extends frame {


  void draw() {
    background(20);
    fill(200);
    //stroke(255);
    
    for (PVector p : points) {
      if(p.x/p.y > 3){
        fill(255,0,0);
        noStroke();
        ellipse( p.x, p.y, 4, 4);
      }else if(p.x/p.y < 0.5){
        fill(255,204,204);
        noStroke();
        ellipse( p.x, p.y, 4, 4);
      }else{
        fill(240,128,128);
        noStroke();
        ellipse( p.x, p.y, 4, 4);
      }
    }
    fill(200);
    drawEmbellishment();
    //drawGrid();
    drawGridNoLie();
    //Only for testing bounds
    //drawTestBox();
    
  }
  
  void drawTestBox(){
    stroke(255,0,0);
    noFill();
    rect(buffer,buffer,canvasWidth-buffer,canvasHeight-buffer);
  }
  
  void drawGrid(){ 
    
    //Draws a 10x10 grid in our graph area.
    int diffY = (canvasHeight-buffer)/10;
    float incrementX = (int)((maxX-minX)/10);
    float incrementY = (int)((maxY-minY)/10);
    for (int i=0; i <= 10; i++){
      //Ten text labels  
      textAlign(LEFT);
      text(((nf((i*incrementY),0,1))),5,(canvasHeight-(i*diffY)));
      //text label lines
      stroke(200,100);
      line(buffer,(canvasHeight-(i*diffY)),canvasWidth, (canvasHeight-(i*diffY)) );
    }
    int diffX = (canvasWidth-buffer)/10;
    for (int i=0; i<=10; i++){
      //ten vertical lines
      stroke(200,100);
      line((buffer+(i*diffX)),buffer, (buffer+(i*diffX)),canvasHeight );
      //labels for ten lines
      textAlign(LEFT);
      text((nf((i*incrementX),0,1)),(buffer+(i*diffX)),height-15);
    
    }
  }
    void drawGridNoLie(){ 
    //Draws a 10x10 grid in our graph area.
    int diffY = (canvasHeight-buffer)/10;
    float incrementX = (int)((maxX-0)/10);
    float incrementY = (int)((maxY-0)/10);
    for (int i=0; i <= 10; i++){
      //Ten text labels 
      //if(graphX == checkText){
        textAlign(LEFT);
        text(((nf((i*incrementY),0,1))),5,(canvasHeight-(i*diffY)));
      //}
      //text label lines
      stroke(200,100);
      line(buffer,(canvasHeight-(i*diffY)),canvasWidth, (canvasHeight-(i*diffY)) );
    }
    int diffX = (canvasWidth-buffer)/10;
    for (int i=0; i<=10; i++){
      //ten vertical lines
      stroke(200,100);
      line((buffer+(i*diffX)),buffer, (buffer+(i*diffX)),canvasHeight );
      //labels for ten lines
      //if(graphX == checkText){
        textAlign(LEFT);
        text((nf((i*incrementX),0,1)),(buffer+(i*diffX)),height-15);
      //}
    }
  }
  void drawEmbellishment(){
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      stroke(200,100);
      if(i==0 ){
        //line(p.x, buffer, p.x, canvasHeight);
      }
      textAlign(LEFT);
      if(points.size() < 15){
        text(column0[i], p.x -15 , canvasHeight+20);
        text(column1[i], p.x -15 , p.y-15);
      }
    }
    
   
    
    textAlign(LEFT);
    //text(maxLine,5,buffer);
    //text(((maxLine)/2),5,(height)/2);
    //text(minOverall,5,canvasHeight);
   
    stroke(200,100);
    //Draw lines on y axis
    //line(buffer-3,height/2,canvasWidth+3,height/2); //prints mid line
    //line(buffer-3,canvasHeight,canvasWidth+3,canvasHeight); //prints x-axis
    //line(buffer-3,buffer,canvasWidth+3,buffer); //prints top line

    textAlign(CENTER);
    textSize(18);
    text(graphHeader,width/2,20);
    textSize(8);
    text(graphX, width/2, height-4);
  }
}