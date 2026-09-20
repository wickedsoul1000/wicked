int BaseNumber = 24;

void setup(){
  mijnMethode(BaseNumber,59);
    mijnMethode(BaseNumber,65);
}

void draw(){
  
}

void mijnMethode(int getal, int getaltwee){
  int totaal = getal + getaltwee;
  println(" " + getal + " + " + getaltwee + " = " + totaal);
}
