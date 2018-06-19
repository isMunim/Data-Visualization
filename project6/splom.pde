

class Splom extends Frame {
  
    ArrayList<Scatterplot> plots = new ArrayList<Scatterplot>( );
    ArrayList<Scatterplot> detailPlots = new ArrayList<Scatterplot>( );
    int colCount;
    Table data;
    int border = 20;
    

   Splom( Table data, ArrayList<Integer> useColumns ){
     this.data = data;
     colCount = useColumns.size();
     for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
           Scatterplot sp = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
           plots.add(sp);
           Scatterplot detailView = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
           detailPlots.add(detailView);
       }
     }
       

    splomSize = plots.size(); 
   }
   
   void setPosition( int u0, int v0, int w, int h ){
    super.setPosition(u0,v0,w,h);

    int curPlot = 0;
    for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
         Scatterplot detailView = detailPlots.get(curPlot);
          Scatterplot sp = plots.get(curPlot++);
          
           int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
           int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
           sp.setPosition( su0, sv0, (int)(w-2*border)/(colCount-1), (int)(h-2*border)/(colCount-1) );
           sp.drawLabels = true;
           sp.border = 3;
           detailView.setPosition (0+border, 0+border, 400-border, 400-border);
           detailView.border = 3;
     }
    }
     
  }

   
   void draw() {
     
     for( Scatterplot s : plots ){
        s.draw(); 
     }
     selectedSPLOM.clear();
     if (dvToggle < plots.size()) {
       Scatterplot v = detailPlots.get(dvToggle);
       v.draw();
       //v.drawGrid();
     } 
     
   }
   

  void mousePressed(){ 

    for( Scatterplot sp : plots ){
       if( sp.mouseInside() ){
          println(sp.idx0 + " " + sp.idx1);
          if (sp.idx0 == 0 && sp.idx1 == 1) {
          dvToggle=0;
        }
        if (sp.idx0 == 0 && sp.idx1 == 2) {
          dvToggle=1;
        }
        if (sp.idx0 == 0 && sp.idx1 == 3) {
          dvToggle=2;
        }
        if (sp.idx0 == 1 && sp.idx1 == 2) {
          dvToggle=3;
        }
        if (sp.idx0 == 1 && sp.idx1 == 3) {
          dvToggle=4;
        }
        if (sp.idx0 == 2 && sp.idx1 == 3) {
          dvToggle=5;
        }
       }
    }
  }
}