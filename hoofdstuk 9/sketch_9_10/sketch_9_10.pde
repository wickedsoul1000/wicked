void setup(){
  size(400,400);  
}

void draw(){
  background(80,33,11);
  boomOnder(200, 350, 200, 100);
    boomOnder(250, 100, 250, 350);
        boomOnder(200, 100, 250, 100);
            boomOnder(200, 350, 250, 350);
            
              boomOnder(70, 350, 70, 100);
    boomOnder(150, 100, 150, 350);
        boomOnder(50, 100, 150, 100);
            boomOnder(200, 350, 250, 350);
            
                       boomOnder(270, 350, 270, 100);
                       
                                   boomOnder(50, 350, 50, 100);
                     

fill(0,255,0);
  for(int i =1; i<=5; i++){
    ellipse(25, 350, i * 25, i * 25);
      ellipse(100, 350, i * 25, i * 25);
            ellipse(175, 350, i * 25, i * 25);
                  ellipse(250, 350, i * 25, i * 25);
                        ellipse(325, 350, i * 25, i * 25);
                              ellipse(400, 350, i * 25, i * 25);
                              
                                 ellipse(110, 70, i * 30, i * 30);
                                 
ellipse(235, 100, i * 30, i * 30);
  }
}
void boomOnder(int x1, int y1, int x2, int y2){
  
   line(x1, y1, x2, y2);
  line(x2, y2, x1, y1);
}
