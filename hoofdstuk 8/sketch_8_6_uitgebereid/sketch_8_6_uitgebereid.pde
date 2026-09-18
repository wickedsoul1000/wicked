size(400,400);
background(255,111,60);

int CircleSize = 300;

for(int i = 1; i <= 50; i++){
  
  ellipse(0 - CircleSize/-2,0 - CircleSize/-2,CircleSize,CircleSize);
  CircleSize = CircleSize - 5;
}
