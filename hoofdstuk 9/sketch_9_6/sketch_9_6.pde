void setup(){
size(400, 400);
  }
void draw(){
background(255, 0, 255);
noFill();

  for(int i =1; i<=5; i++){
ellipse(300, 200, i * 30, i * 30);
}
}
