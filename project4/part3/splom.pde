

class Splom extends Frame {

  ArrayList<Scatterplot> plots = new ArrayList<Scatterplot>( );
  ArrayList<Scatterplot> detailPlots = new ArrayList<Scatterplot>( );
  int colCount;
  Table data;
  float border = 20;
  
  //float borderX = 

  Splom( Table data, ArrayList<Integer> useColumns ) {
    this.data = data;
    colCount = useColumns.size();
    for ( int j = 0; j < colCount-1; j++ ) {
      for ( int i = j+1; i < colCount; i++ ) {
        Scatterplot sp = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
        Scatterplot detailView = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
        plots.add(sp);
        detailPlots.add(detailView);
      }
    }


    //table.getColumnCount()
    //table.getColumnType(int column) != Table.STRING
    //table.getColumnTitle();
  }

  void setPosition( int u0, int v0, int w, int h ) {
    super.setPosition(u0, v0, w, h);

    int curPlot = 0;
    for ( int j = 0; j < colCount-1; j++ ) {
      for ( int i = j+1; i < colCount; i++ ) {
        Scatterplot detailView = detailPlots.get(curPlot++);
        //Scatterplot sp = plots.get(curPlot++);
        //int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
        //int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
        detailView.setPosition( i+50, j+50, 500, 500 );
        detailView.drawLabels = true;
        detailView.border = 3;
        //detailView.setPosition (50, 210, 350, 350);
        //detailView.border = 3;
      }
    }
  }


  void draw() {
    background(20);
    fill(200);
    stroke(255);
    //for ( Scatterplot s : plots ) {
    //  s.draw();
    //}
    
    //rect(50,210, 350,350);
    text("Hint: Click to see magic", 53,580);
    
    if (dvToggle==0) {
      Scatterplot v = detailPlots.get(0);
      v.draw();
    } else if (dvToggle==1) {
      Scatterplot v = detailPlots.get(1);
      v.draw();
    } else if (dvToggle==2) {
      Scatterplot v = detailPlots.get(2);
      v.draw();
    } else if (dvToggle==3) {
      Scatterplot v = detailPlots.get(3);
      v.draw();
    } else if (dvToggle==4) {
      Scatterplot v = detailPlots.get(4);
      v.draw();
    } else if (dvToggle==5) {
      Scatterplot v = detailPlots.get(5);
      v.draw();
    }
  }


  void mousePressed() { 
    //for ( Scatterplot sp : plots ) {
    //  if ( sp.mouseInside() ) {
    //    // do something!!! OKay ^-^
    //    //println(sp.idx0 + " " + sp.idx1);
    //    if (sp.idx0 == 0 && sp.idx1 == 1) {
    //      dvToggle=0;
    //    }
    //    if (sp.idx0 == 0 && sp.idx1 == 2) {
    //      dvToggle=1;
    //    }
    //    if (sp.idx0 == 0 && sp.idx1 == 3) {
    //      dvToggle=2;
    //    }
    //    if (sp.idx0 == 1 && sp.idx1 == 2) {
    //      dvToggle=3;
    //    }
    //    if (sp.idx0 == 1 && sp.idx1 == 3) {
    //      dvToggle=4;
    //    }
    //    if (sp.idx0 == 2 && sp.idx1 == 3) {
    //      dvToggle=5;
    //    }
    //  }
    //}
    if(dvToggle == 6){
      dvToggle = -1;
    }
    dvToggle++;
  }
}