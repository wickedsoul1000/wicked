class Person {
  String naam;
  int leeftijd;
  String geslacht;

  Person(String naam, int leeftijd, String geslacht) {
    this.naam = naam;
    this.leeftijd = leeftijd;
    this.geslacht = geslacht;
  }

  void toonNaam() {
    println("Naam: " + naam);
  }

  void toonLeeftijd() {
    println("Leeftijd: " + leeftijd);
  }
}

void setup() {
  Person persoon1 = new Person("Jan", 14, "man");
  Person persoon2 = new Person("Roos", 17, "vrouw");

  persoon1.toonNaam();
  persoon1.toonLeeftijd();

  persoon2.toonNaam();
  persoon2.toonLeeftijd();
}
