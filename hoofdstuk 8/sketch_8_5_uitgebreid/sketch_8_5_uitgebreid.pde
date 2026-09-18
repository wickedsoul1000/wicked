size(400, 400);
background(255, 0, 255);
int sizeC = 200;
for (int i = 0; i < 50; i++) {
  ellipse(200, 200, sizeC, sizeC);
  sizeC = sizeC - 5;
}
