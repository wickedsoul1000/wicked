import processing.video.*;

Movie turboVideo;


Note[] notes = new Note[4];

int score = 0;
float hitY = 80;
float timingWindow = 35;

void setup() {
  size(500,500);

  println(dataPath("turboVideo.mp4"));
  
  turboVideo = new Movie(this, "turboVideo.mp4");
  turboVideo.play();

  notes[0] = new Note(60, height + 30, 3500, 0);   // A
 notes[1] = new Note(185, height + 30, 3500, 1);   // S
 notes[2] = new Note(315, height + 30, 6500, 2);  // W
  notes[3] = new Note(440, height + 30, 6500, 3);  // D

  
  
}

void draw() {
  background(0);
  
  image(turboVideo,0,0, width, height);

  fill(0,0,255);
  textSize(20);
  text("Score: " + score, 10, 30);

  line(120, height, 120, 0);
  line(250, height, 250, 0);
  line(380, height, 380, 0);
  line(0, hitY, width, hitY);

  for (int i = 0; i < notes.length; i++) {
    notes[i].move();
    notes[i].display();
  }
}

void keyPressed() {
  int pressedLane = -1;

  if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
    pressedLane = 0;
    println("LEFT");
  } else if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
    pressedLane = 1;
    println("UP");
  } else if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
    pressedLane = 2;
    println("DOWN");
  } else if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
    pressedLane = 3;
    println("RIGHT");
  }

  if (pressedLane == -1) {
    return;
  }

  for (int i = 0; i < notes.length; i++) {
    if (notes[i].tryHit(pressedLane)) {
      break;
    }
  }
}

class Note {
  int lane;
  float x, y;
  float speedY = -6;
  float noteSize = 60;
  
  int spawnTime;

  Note(float startX, float startY, int delay, int startLane) {
    x = startX;
    y = startY;
    lane = startLane;
    
    spawnTime = millis() + delay;
  }

  boolean tryHit(int pressedLane) {
    if (millis() < spawnTime || pressedLane != lane) {
      return false;
    }

    if (abs(y - hitY) <= timingWindow) {
      score += 100;
      resetNote();
      return true;
    }

    return false;
  }

  void resetNote() {
    y = height + noteSize / 2;
    spawnTime = millis() + int((3000));
  }

  void move() {
    if (millis() < spawnTime) {
      return;
    }

    y += speedY;

    if (y < hitY - timingWindow) {
      score -= 10;
      resetNote();
    }
  }

  void display() {
    if (millis() < spawnTime) {
      return;
    }

    ellipse(x, y, noteSize, noteSize);
  }
}

void movieEvent(Movie m) {
  m.read();
}
