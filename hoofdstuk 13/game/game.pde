//video shit

import processing.video.*;

Movie turboVideo;

//zodat alle notes in het program zitten

ArrayList <Note> notes = new ArrayList<Note>();

//scores for the notes die je hit of missed


int score = 0;
int songStartTime;

float chartOffset = 1000;

float hitY = 80;
float timingWindow = 35;

void setup() {
  size(500, 500);


//video

  println(dataPath("turboVideo.mp4"));

  turboVideo = new Movie(this, "turboVideo.mp4");
  turboVideo.play();
  
  //json ding

  loadChart();
}



void loadChart() {

  JSONObject chart = loadJSONObject("turbo(2).json");

  if (chart == null) {
    println("ERROR: JSON file not found!");
    return;
  }

  JSONArray sections = chart.getJSONArray("notes");

  for (int s = 0; s < sections.size(); s++) {

    JSONObject section = sections.getJSONObject(s);

    JSONArray sectionNotes =
      section.getJSONArray("sectionNotes");

    boolean mustHitSection =
      section.getBoolean("mustHitSection");

    for (int n = 0; n < sectionNotes.size(); n++) {

      JSONArray note =
        sectionNotes.getJSONArray(n);

      float time = note.getFloat(0);
      int lane = note.getInt(1);
      float sustain = note.getFloat(2);

      // Player notes
      if (mustHitSection && lane < 4) {

        float x;

        if (lane == 0) {
          x = 60;
        } else if (lane == 1) {
          x = 185;
        } else if (lane == 2) {
          x = 315;
        } else {
          x = 440;
        }

        // ADD THE NOTE TO THE ARRAYLIST
        notes.add(new Note(x, height + 30, time, lane));

        println(
          "Added note: " +
          time +
          "ms lane " +
          lane +
          " sustain " +
          sustain
        );
      }
    }
  }

  println("TOTAL NOTES: " + notes.size());
}

void draw() {
  background(0);

  image(turboVideo, 0, 0, width, height);

  fill(0, 0, 255);
  textSize(20);
  text("Score: " + score, 10, 30);

  line(120, height, 120, 0);
  line(250, height, 250, 0);
  line(380, height, 380, 0);
  line(0, hitY, width, hitY);

for (Note note : notes) {
    note.move();
  }
}

void keyPressed() {
  int pressedLane = -1;

  if (key == 'a' || key == 'A' || (key == CODED && keyCode == LEFT)) {
    pressedLane = 0;
    println("LEFT");
  } else if (key == 's' || key == 'S' || (key == CODED && keyCode == DOWN)) {
    pressedLane = 1;
    println("DOWN");
  } else if (key == 'w' || key == 'W' || (key == CODED && keyCode == UP)) {
    pressedLane = 2;
    println("UP");
  } else if (key == 'd' || key == 'D' || (key == CODED && keyCode == RIGHT)) {
    pressedLane = 3;
    println("RIGHT");
  }

  if (pressedLane == -2) {
    return;
  }

  for (int i = 0; i < notes.size(); i++) {
    if (notes.get (i) .tryHit(pressedLane)) {
      break;
    }
  }
}

class Note {
  int lane;

  float x, y;
  float noteSize = 60;

  // When the note should be hit
  float hitTime;

  boolean hit = false;
  boolean missed = false;

  Note(float startX, float startY, float noteTime, int startLane) {
    x = startX;
    y = startY;
    lane = startLane;

    // Time from the JSON
    hitTime = noteTime;
  }

  boolean tryHit(int pressedLane) {

    if (pressedLane != lane) {
      return false;
    }

    // Current song time
    float currentTime = turboVideo.time() *1000.0;

    // Difference between current time and note time
    float difference = abs(currentTime - hitTime);

    if (difference <= timingWindow) {

      score += 100;
      hit = true;

      println("HIT!");
      println("Note time: " + hitTime + " ms");
      println("Difference: " + difference + " ms");

      return true;
    }

    return false;
  }

  void move() {

    if (hit || missed) {
      return;
    }

    // Current song time
   // float currentTime = millis() - songStartTime;
       float currentTime = turboVideo.time() *1000.0;
       

    // How long until the note should be hit
    float timeUntilHit = hitTime - currentTime;

    // Convert milliseconds to seconds
    float secondsUntilHit = timeUntilHit / 1000.0;

    // Position the note
    y = hitY + secondsUntilHit * 580;

    // Missed the note
    if (currentTime > hitTime + timingWindow) {

      score -= 10;
      missed = true;

      println("MISS!");
      println("Note time: " + hitTime + " ms");
    }
 
    // Don't show notes that are too far below
    if (y > height + noteSize) {
      return;
    }

    ellipse(x, y, noteSize, noteSize);
    
    ellipse(x, y, noteSize, noteSize);
  }
  }

void movieEvent(Movie m) {
  m.read();
}
