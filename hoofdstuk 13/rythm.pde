// ai heb ik alleen gebruikt om een beetje hulp voor de rest heb ik het zelf gedaan
// oh waar ik ai echt wat heb gebruikt is om he .json file die ik had waarin de notes stond te converten naar processing
// was best lastig heb wel veel nieuwe dingen geleerd erdoor was heel lastig om het te doen maar is gelukt. maar ja voor de rest heb ik zelf
// gemaakt door het te opzoeken en te leren hoe het werkt. (ai hielp me ook om het een beetje netter eruit te laten zien)



import processing.video.*;
import java.util.ArrayList;


// VIDEO

Movie turboVideo;




// NOTES

ArrayList<ChartNote> notes = new ArrayList<ChartNote>();


// GAME SETTINGS


// Hit line position
float hitY = 80;

// Note speed in PIXELS PER SECOND
float noteSpeed = 550;

// How close the player has to be
// 35 milliseconds = fairly forgiving
float timingWindow = 80;

// Size of note
float noteSize = 60;


// GAME VARIABLES

int score = 0;
int misses = 0;

// Time when the song/chart starts
int songStartTime;

// Prevents the song from starting twice
boolean gameStarted = false;


// SETUP

void setup() {

  size(500, 600);

  println("--------------------------------");
  println("Starting Processing FNF Game");
  println("--------------------------------");


 
  // LOAD VIDEO

  println("Video:");
  println(dataPath("turboVideo.mp4"));

  turboVideo = new Movie(this, "turboVideo.mp4");

  turboVideo.play();


  // LOAD CHART

  loadChart();


  // START GAME TIMER

  songStartTime = millis();

  gameStarted = true;


  println("--------------------------------");
  println("Game started!");
  println("Notes loaded: " + notes.size());
  println("--------------------------------");
}


// DRAW

void draw() {

  background(0);


  // VIDEO

  if (turboVideo.width > 0) {

    image(
      turboVideo,
      0,
      0,
      width,
      height
      );
  }



  // SONG TIME


  float songTime = millis() - songStartTime;


  // UI

  fill(255);

  textSize(20);

  text(
    "Score: " + score,
    10,
    30
    );

  text(
    "Misses: " + misses,
    10,
    55
    );


  // Current time

  textSize(14);

  text(
    "Time: " +
    nf(songTime / 1000.0, 0, 2) +
    "s",
    10,
    75
    );


  // LANES

  stroke(255);

  line(
    125,
    0,
    125,
    height
    );

  line(
    250,
    0,
    250,
    height
    );

  line(
    375,
    0,
    375,
    height
    );


  // HIT LINE

  strokeWeight(3);

  line(
    0,
    hitY,
    width,
    hitY
    );

  strokeWeight(1);


  // UPDATE NOTES

  for (int i = notes.size() - 1; i >= 0; i--) {

    ChartNote note = notes.get(i);


    // Update note

    note.update(songTime);


    // Draw note

    note.display(songTime);


    // Remove finished notes

    if (note.finished) {

      notes.remove(i);
    }
  }
}


// LOAD PSYCH ENGINE JSON

void loadChart() {

  // IMPORTANT:
  // This is the exact filename of your uploaded chart.

  JSONObject chart =
    loadJSONObject("turbo.json");


  // Check if loading failed

  if (chart == null) {

    println(
      "ERROR: turbo(2).json could not be loaded!"
      );

    println(
      "Make sure it is inside the data folder."
      );

    exit();

    return;
  }


  // GET SECTIONS

  JSONArray sections =
    chart.getJSONArray("notes");


  println(
    "Chart sections: " +
    sections.size()
    );


  // READ EVERY SECTION

  for (int sectionIndex = 0;
       sectionIndex < sections.size();
       sectionIndex++) {


    JSONObject section =
      sections.getJSONObject(sectionIndex);



    boolean mustHit =
      section.getBoolean(
        "mustHitSection"
        );


   

    JSONArray sectionNotes =
      section.getJSONArray(
        "sectionNotes"
        );


    for (int i = 0;
         i < sectionNotes.size();
         i++) {


      JSONArray noteData =
        sectionNotes.getJSONArray(i);



      float hitTime =
        noteData.getFloat(0);


      int psychLane =
        noteData.getInt(1);


      float sustain =
        noteData.getFloat(2);


      boolean playerNote;


      if (mustHit) {

        playerNote =
          psychLane < 4;

      } else {

        playerNote =
          psychLane >= 4;
      }


      // Ignore opponent notes

      if (!playerNote) {

        continue;
      }


  
      // CONVERT LANE
   
      int lane;


      if (psychLane >= 4) {

        lane =
          psychLane - 4;

      } else {

        lane =
          psychLane;
      }



      ChartNote newNote =
        new ChartNote(
          hitTime,
          lane,
          sustain
          );


      notes.add(newNote);
    }
  }




  notes.sort(
    (a, b) ->
      Float.compare(
        a.hitTime,
        b.hitTime
        )
    );


  println(
    "Player notes loaded: " +
    notes.size()
    );
}



// KEYBOARD

void keyPressed() {

  int pressedLane = -1;


  
  // A / LEFT
  

  if (
    key == 'a' ||
    key == 'A' ||
    (key == CODED && keyCode == LEFT)
    ) {

    pressedLane = 0;
  }



  // S / DOWN


  else if (
    key == 's' ||
    key == 'S' ||
    (key == CODED && keyCode == DOWN)
    ) {

    pressedLane = 1;
  }



  // W / UP

  else if (
    key == 'w' ||
    key == 'W' ||
    (key == CODED && keyCode == UP)
    ) {

    pressedLane = 2;
  }



  // D / RIGHT


  else if (
    key == 'd' ||
    key == 'D' ||
    (key == CODED && keyCode == RIGHT)
    ) {

    pressedLane = 3;
  }


  // No valid key

  if (pressedLane == -1) {

    return;
  }



  // CURRENT SONG TIME


  float songTime =
    millis() - songStartTime;



  // FIND CLOSEST NOTE


  ChartNote closestNote = null;

  float closestDistance =
    Float.MAX_VALUE;


  for (int i = 0;
       i < notes.size();
       i++) {


    ChartNote note =
      notes.get(i);


    // Wrong lane

    if (note.lane != pressedLane) {

      continue;
    }


    // Already dealt with

    if (note.hit || note.missed) {

      continue;
    }


    // Difference between
    // current time and note time

    float distance =
      abs(
        songTime -
        note.hitTime
        );


    // Is this closer than the previous note?

    if (
      distance <= timingWindow &&
      distance < closestDistance
      ) {

      closestDistance =
        distance;

      closestNote =
        note;
    }
  }


  // ==========================================================
  // HIT
  // ==========================================================

  if (closestNote != null) {

    closestNote.hit = true;

    score += 100;


    println(
      "HIT!"
      );

    println(
      "Lane: " +
      pressedLane
      );

    println(
      "Timing difference: " +
      (songTime - closestNote.hitTime) +
      " ms"
      );
  }


  // ==========================================================
  // NOTHING HIT
  // ==========================================================

  else {

    println(
      "No note hit"
      );
  }
}


// ============================================================
// NOTE CLASS
// ============================================================

class ChartNote {

  // ==========================================================
  // NOTE DATA
  // ==========================================================

  float hitTime;

  int lane;

  float sustain;


  // ==========================================================
  // NOTE STATE
  // ==========================================================

  boolean hit = false;

  boolean missed = false;

  boolean finished = false;


  // ==========================================================
  // CONSTRUCTOR
  // ==========================================================

  ChartNote(
    float noteTime,
    int noteLane,
    float noteSustain
    ) {


    hitTime =
      noteTime;


    lane =
      noteLane;


    sustain =
      noteSustain;
  }


  // ==========================================================
  // UPDATE
  // ==========================================================

  void update(float songTime) {


    // --------------------------------------------------------
    // Hit
    // --------------------------------------------------------

    if (hit) {

      finished = true;

      return;
    }


    // --------------------------------------------------------
    // Miss
    // --------------------------------------------------------

    if (
      songTime >
      hitTime + timingWindow
      ) {


      missed = true;


      misses++;


      score -= 10;


      println(
        "MISS!"
        );


      finished = true;
    }
  }


  // ==========================================================
  // DISPLAY
  // ==========================================================

  void display(float songTime) {


    // Don't display finished notes

    if (
      hit ||
      missed
      ) {

      return;
    }


    // ========================================================
    // CALCULATE SPAWN TIME
    // ========================================================

    // Distance from bottom to hit line

    float travelDistance =
      (height + noteSize / 2) -
      hitY;


    // How many seconds the note needs
    // to travel to the hit line

    float travelSeconds =
      travelDistance /
      noteSpeed;


    // Convert seconds to milliseconds

    float travelMilliseconds =
      travelSeconds *
      1000.0;


    // When note should appear

    float spawnTime =
      hitTime -
      travelMilliseconds;


    // Don't show it yet

    if (
      songTime <
      spawnTime
      ) {

      return;
    }


    // ========================================================
    // NOTE POSITION
    // ========================================================

    float timeUntilHit =
      hitTime -
      songTime;


    float y =
      hitY +
      (
        timeUntilHit /
        1000.0
        ) *
      noteSpeed;


    // ========================================================
    // LANE POSITION
    // ========================================================

    float x =
      getLaneX(lane);


    // ========================================================
    // SUSTAIN
    // ========================================================

    if (sustain > 0) {


      // Convert sustain milliseconds
      // into pixels

      float sustainPixels =
        (
          sustain /
          1000.0
        ) *
        noteSpeed;


      // Draw sustain behind note

      rectMode(CENTER);


      rect(
        x,
        y + sustainPixels / 2,
        noteSize / 2,
        sustainPixels
        );


      rectMode(CORNER);
    }


    // ========================================================
    // NOTE HEAD
    // ========================================================


fill(0,0,0);
    ellipse(x,y,noteSize,noteSize);
  }


  // ==========================================================
  // GET X POSITION
  // ==========================================================

  float getLaneX(int lane) {


    if (lane == 0) {

      return 62.5;
    }


    if (lane == 1) {

      return 187.5;
    }


    if (lane == 2) {

      return 312.5;
    }


    return 437.5;
  }
}


// ============================================================
// VIDEO EVENT
// ============================================================

void movieEvent(Movie m) {

  m.read();
}
```
