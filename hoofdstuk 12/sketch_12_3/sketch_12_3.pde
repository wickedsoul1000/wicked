class bankAccount {
  
  int rekeningNummer;
  int saldo;
  String eignenaar;
  
  bankAccount(int rekeningNummer, int saldo, String eignenaar) {
    this.rekeningNummer = rekeningNummer;
    this.saldo = saldo;
    this.eignenaar = eignenaar;
    
  }
  
  void opnemen(int bedrag) {
    
    if (bedrag <= 0) {
      println("voor een geldig bedrag");
      
    } else if (bedrag > saldo) {
      println("opnemen misluk, niet genoeg geld");
      
    } else {
      saldo = saldo - bedrag;
      println(bedrag + " euro opgenomen. Nieuwe saldo: " + saldo);
    }
  }
  
  void storten(int bedrag) {
    if ( bedrag <= 0) {
      println("voer een geldig bedrag");
      
    } else {
      saldo = saldo + bedrag;
    }
  }
  
  void toonSaldo() {
  }
}
  
  void setup() {
    bankAccount rekening = new bankAccount(12345,100,"jan");
    
    rekening.storten(50);
    rekening.opnemen(80);
    rekening.opnemen(100);
    
    rekening.toonSaldo();
  }
