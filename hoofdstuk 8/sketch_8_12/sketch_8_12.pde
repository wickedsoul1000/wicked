size(150,150);
background(200,200,300);

int xWaarde = 30;
int yWaarde = 30;

for(int i =2;i <= 10; i++){
  
  for(int j =2; j <= 10; j++){
    rect(xWaarde,yWaarde,10,10);

 if ((i + j) % 2 == 0) {
  fill(255);
} else {
  fill(0);
}
       
            
yWaarde = yWaarde + 10;
  }
  yWaarde =30;
  
  xWaarde = xWaarde +10;
}
