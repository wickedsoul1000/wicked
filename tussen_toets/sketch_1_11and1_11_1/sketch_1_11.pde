//duurde de mij 2 uur om dit vraag goed te krijgen maar nadat we loop hadden geleerd werd het iets makkelijker om te beantworden

int steen1 = 6;
int steen2 = 6;
int steen3 = 6;
boolean luckiesMotherFucker = steen1 ==6 && steen2 ==6 && steen3 ==6;

///&& steen2 ==1 && steen3 ==1

String resultaat = "";
// fucking skill issue miss
if (steen1 == 1 && steen2 == 1 && steen3 == 1) {
    resultaat = "CRITICAL MISS!";
}
// miss
else if (steen1 == 1 || steen2 == 1 || steen3 == 1) {
    resultaat = "mis!";
}
// Hit
else {
    int schade = (steen1 + steen2 + steen3) / 3;
    resultaat = schade + " HIT!";    
}

if (steen1 ==6 && steen2 ==6 && steen3 ==6) {
  println("luckiest mother fucker");
}

print(resultaat);
