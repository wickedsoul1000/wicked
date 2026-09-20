void setup(){
  size(400,400);  
}

void draw(){
  background(255,255,255);
  boomOnder(200, 350, 200, 100);
    boomOnder(250, 100, 250, 350);
        boomOnder(200, 100, 250, 100);
            boomOnder(200, 350, 250, 350);

fill(0,255,0);
  for(int i =1; i<=5; i++){
ellipse(225, 100, i * 30, i * 30);
  }
}
void boomOnder(int x1, int y1, int x2, int y2){
  
   line(x1, y1, x2, y2);
  line(x2, y2, x1, y1);
}
