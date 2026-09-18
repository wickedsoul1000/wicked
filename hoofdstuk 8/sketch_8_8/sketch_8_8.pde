int i = 0;
int y = 1;

for (;i <= 100;){
  println(i);
  
  int tellen = i + y;
  i = y;
  y = tellen;
}
