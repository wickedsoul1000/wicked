size(150,150);
background(200,200,300);

int xWaarde = 20;
int yWaarde = 20;

for(int i =1;i <= 10; i++){
  for(int j =1; j <= 10; j++){
    rect(xWaarde,yWaarde,10,10);
    yWaarde = yWaarde + 10;
  }
  yWaarde =20;
  
  xWaarde = xWaarde +10;

}
