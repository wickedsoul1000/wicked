int[] getallen = {1,2,3,4,5,6,7,8,9,10};
int zoekwaarde = 7;
int zoekwaarde2 = 10;
int zoekwaarde3 = 3;
int aantal =0;

void setup(){
  for (int i = 0; i < getallen.length; i++) {
    if(getallen [i] == zoekwaarde) {
      aantal++;
    }
  }
  println ("het getal " + zoekwaarde + "  komt " + aantal + " keer voor.");
  println ("het getal " + zoekwaarde2 + "  komt " + aantal + " keer voor.");
    println ("het getal " + zoekwaarde3 + "  komt " + aantal + " keer voor.");
}
