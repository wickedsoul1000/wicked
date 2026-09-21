class Rectangle {
    float breedte;
  float hoogte;
  float x;
  float y;
  
  Rectangle(float breedte,float hoogte,float x,float y) {
    
    this. breedte = breedte;
    this.hoogte = hoogte;
    this.x = x;
    this.y = y;
  } 
  
  void Recti() {
      rect(x,y,x,y);
  }
}
  
  void setup(){
    size(400,400);
    
    Rectangle myRectangle = new Rectangle (100,100,170,100);
    
    myRectangle.Recti();
    
    
  }
