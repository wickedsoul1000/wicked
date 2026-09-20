int jan =0;
int piet=1;

boolean gevonden;
int[] namen = {0,1}; 

void setup(){
  gevonden =true;
  for (int i =0; i <namen.length;i++){
    // bestaat de volgende waarde?
    if(namen[i] == jan){
      gevonden =true;
      
      println(gevonden);
    }
  }
}
