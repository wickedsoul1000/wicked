size(200,200);
background(255,111,60);

int CircleSize = 100;

for(int i = 1; i <= 5; i++){
  
  ellipse(100 - CircleSize/5,100 - CircleSize/5,CircleSize,CircleSize);
  CircleSize = CircleSize - 10;
}
