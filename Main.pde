import java.util.ArrayList;
import ddf.minim.*;

boolean isDrawing = false;
boolean clearOnce = true;
boolean animate = false;
boolean overlapping = false;

int timerDuration = 60;
int startTime;

// List of all drawn things:
ArrayList<Line> Lines;
ArrayList<Dot> Dots;
ArrayList<Square> Squares;

Button Clear, BrushType, Animate, Sound;
Text SizeText, RedText, GreenText, BlueText, AlphaText, TypeText, TimerText;
Slider SizeSlider, RedSlider, GreenSlider, BlueSlider, AlphaSlider;

// Audio Setup:
Minim Piano;
AudioPlayer[] pianoKey = new AudioPlayer[8]; 

void setup() {
  size(1200, 800);
  
  // Button Parameters: 
  // X, Y, Width, Height, Red, Green, Blue, Outline, Label, Size
  
  // Text Parameters:
  // X, Y, Label, Size, Variable
  
  // Slider Parameters:
  // X, Y, Width, Height, Minimum, Maximum, Current, Red, Green, Blue
  
  // Stroke Weight
  SizeText = new Text(75, 30, "Size: ", 25, 10);
  SizeSlider = new Slider(25, 60, 100, 20, 0, 99, 10, 50, 50, 50);
  
  // Red
  RedText = new Text(200, 30, "Red: ", 25, 0);
  RedSlider = new Slider(150, 60, 100, 20, 0, 255, 0, 255, 0, 0);
  
  // Green
  GreenText = new Text(325, 30, "Green: ", 25, 0);
  GreenSlider = new Slider(275, 60, 100, 20, 0, 255, 0, 0, 255, 0);
  
  // Blue
  BlueText = new Text(450, 30, "Blue: ", 25, 0);
  BlueSlider = new Slider(400, 60, 100, 20, 0, 255, 0, 0, 0, 255);
  
  // Alpha
  AlphaText = new Text(575, 30, "Alpha: ", 25, 0);
  AlphaSlider = new Slider(525, 60, 100, 20, 0, 255, 255, 255, 255, 255);
  
  // Brush Type
  TypeText = new Text(725, 30, "Brush Type: ", 25);
  BrushType = new Button(725, 60, 100, 30, 150, 150, 250, 5, "Line", 25);
  
  // Brush Preview appears between here.
  
  // Sound
  Sound = new Button(1000, 20, 100, 30, 150, 150, 250, 5, "Sound", 25);
  
  // Animate
  Animate = new Button(1000, 60, 100, 30, 150, 150, 250, 5, "Animate", 25);
  
  // Timer
  startTime = millis();
  TimerText = new Text(1125, 30, "Time: ", 25, timerDuration);
  
  // Clear
  Clear = new Button(1125, 60, 100, 30, 150, 150, 250, 5, "Clear", 25);
  
  // Initialise all lists:
  Lines = new ArrayList<Line>();
  Dots = new ArrayList<Dot>();
  Squares = new ArrayList<Square>();
  
  background(255);
  
  // Loading all audio clips:
  Piano = new Minim(this);
  pianoKey[0] = Piano.loadFile("Piano/Piano_C4.wav");
  pianoKey[1] = Piano.loadFile("Piano/Piano_D4.wav");
  pianoKey[2] = Piano.loadFile("Piano/Piano_E4.wav");
  pianoKey[3] = Piano.loadFile("Piano/Piano_F4.wav");
  pianoKey[4] = Piano.loadFile("Piano/Piano_G4.wav");
  pianoKey[5] = Piano.loadFile("Piano/Piano_A4.wav");
  pianoKey[6] = Piano.loadFile("Piano/Piano_B4.wav");
  pianoKey[7] = Piano.loadFile("Piano/Piano_C5.wav");
  
}

void draw() { 
  
  // Canvas
  if (clearOnce || animate){   
    fill(255);
    strokeWeight(0);
    stroke(0);
    rect(0, 100, 1200, 800);
    clearOnce = false;
  }
  
  // Tools Panel
  fill(240);
  strokeWeight(0);
  stroke(0);
  rect(0, 0, 1200, 105);
  
  // Brush Size
  SizeText.display();
  SizeSlider.display();
  SizeSlider.update();
  SizeText.changeVariable(int(SizeSlider.getValue()));
  
  // Red Paint
  RedText.display();
  RedSlider.display();
  RedSlider.update();
  RedText.changeVariable(int(RedSlider.getValue()));
  
  // Green Paint
  GreenText.display();
  GreenSlider.display();
  GreenSlider.update();
  GreenText.changeVariable(int(GreenSlider.getValue()));
  
  // Blue Paint
  BlueText.display();
  BlueSlider.display();
  BlueSlider.update();
  BlueText.changeVariable(int(BlueSlider.getValue()));
  
  // See-through Paint
  AlphaText.display();
  AlphaSlider.display();
  AlphaSlider.update();
  AlphaText.changeVariable(int(AlphaSlider.getValue()));
  
  // Brush Type
  TypeText.display();
  BrushType.display();
  
  // Brush Preview
  if (SizeSlider.getValue() == 0){
    if (BrushType.getLabel() == "Line"){
      strokeWeight(0.5);
      stroke(RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
      line(870, 53, 880, 53);
    }
    else if (BrushType.getLabel() == "Dot"){
      noStroke();
      fill(RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
      ellipse(875, 53, 0.5, 0.5);
    }
    else if (BrushType.getLabel() == "Square"){
      noStroke();
      fill(RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
      rect(875, 53, 0.5, 0.5);
    }
  }
  else{
    if (BrushType.getLabel() == "Line"){
      strokeWeight(SizeSlider.getValue());
      stroke(RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
      line(850, 53, 880, 53);
    }
    else if (BrushType.getLabel() == "Dot"){
      noStroke();
      fill(RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
      ellipse(865, 53, SizeSlider.getValue(), SizeSlider.getValue());
    }
    else if (BrushType.getLabel() == "Square"){
      noStroke();
      fill(RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
      rect((865 - (SizeSlider.getValue()/2)), (53 - (SizeSlider.getValue()/2)), SizeSlider.getValue(), SizeSlider.getValue());
    }
  }
  
  // Sound Button
  Sound.display();
  
  // Animate Button
  Animate.display();
  
  // Timer
  TimerText.display();
  int elapsedSeconds = (millis() - startTime) / 1000;
  int remainingTime = max(timerDuration - elapsedSeconds, 0);
  TimerText.changeVariable(remainingTime);
    
  // Clear button
  Clear.display();
  
  // Sketch Drawings
  if ((millis() - startTime) / 1000 < timerDuration) {
    if (Lines.size() != 0){
      for (Line sketch : Lines){
        sketch.display();
      }
    }
    if (Dots.size() != 0){
      for (Dot spot : Dots){
        spot.display();
      }
    }
    if (Squares.size() != 0){
      for (Square quad : Squares){
        quad.display();
      }
    }
  }
  
  // Animations
  else {
    Clear.ChangeLabel("Reset");
    
    if (Animate.getLabel() == "Animate"){
      
      animate = true;
      if (Lines.size() != 0){
        for (Line sketch : Lines){
          sketch.update();
        }
      }
      if (Dots.size() != 0){
        for (Dot spot : Dots){
          spot.update();
        }
      }
      if (Squares.size() != 0){
        for (Square quad : Squares){
          quad.update();
        }
      }
      
    }
    else if (Animate.getLabel() == "Freeze"){
      if (Lines.size() != 0){
        for (Line sketch : Lines){
          sketch.display();
        }
      }
      if (Dots.size() != 0){
        for (Dot spot : Dots){
          spot.display();
        }
      }
      if (Squares.size() != 0){
        for (Square quad : Squares){
          quad.display();
        }
      }
    }
    else if (Animate.getLabel() == "Overlap"){
      
      animate = false;
      if (Lines.size() != 0){
        for (Line sketch : Lines){
          sketch.update();
        }
      }
      if (Dots.size() != 0){
        for (Dot spot : Dots){
          spot.update();
        }
      }
      if (Squares.size() != 0){
        for (Square quad : Squares){
          quad.update();
        }
      }
      
    }
  }
}

void mousePressed() {
  if (mouseY > 100){
    isDrawing = true;  // Start drawing when mouse is pressed
  }
  
  // Check if slider is pressed:
  SizeSlider.pressed();
  RedSlider.pressed();
  GreenSlider.pressed();
  BlueSlider.pressed();
  AlphaSlider.pressed();
  
  // Check if the Brush Type button is pressed:
  if (BrushType.checkClick()){
    if (BrushType.getLabel() == "Line"){
      BrushType.ChangeLabel("Dot");
    }
    else if (BrushType.getLabel() == "Dot"){
      BrushType.ChangeLabel("Square");
    }
    else if (BrushType.getLabel() == "Square"){
      BrushType.ChangeLabel("Line");
    }
  }
  
  // Check if the Sound button is pressed:
  if (Sound.checkClick()){
    if (Sound.getLabel() == "Sound"){
      Sound.ChangeLabel("Mute");
    }
    else if (Sound.getLabel() == "Mute"){
      Sound.ChangeLabel("Sound");
    }
  }
  
  // Check if the Animate button is pressed:
  if (Animate.checkClick()){
    if (Animate.getLabel() == "Animate"){
      Animate.ChangeLabel("Freeze");
    }
    else if (Animate.getLabel() == "Freeze"){
      if (overlapping){
        Animate.ChangeLabel("Animate");
        overlapping = !overlapping;
      }
      else{
        Animate.ChangeLabel("Overlap");
        overlapping = !overlapping;
      }
    }
    else if (Animate.getLabel() == "Overlap"){
      Animate.ChangeLabel("Freeze");
    }
  }
  
  // Check if Clear button is pressed
  if ((millis() - startTime) / 1000 < timerDuration) {
    if (Clear.checkClick()){
      Lines.clear();
      Dots.clear();
      Squares.clear();
      clearOnce = true;
    }
  }
  
  // Check if Reset button is pressed
  else {
    if (Clear.checkClick()){
      Lines.clear();
      Dots.clear();
      Squares.clear();
      startTime = millis();
      Clear.ChangeLabel("Clear");
      clearOnce = true;
      animate = false;
    }
  }
}

void mouseReleased() {
  isDrawing = false; // Stop drawing when mouse is released
  
  // Check if slider is released
  SizeSlider.released();
  RedSlider.released();
  GreenSlider.released();
  BlueSlider.released();
  AlphaSlider.released();
}

void mouseDragged() {
  if ((millis() - startTime) / 1000 < timerDuration) {
    if (isDrawing && mouseY >= 100) {
   
      // Draw with lines
      if (BrushType.getLabel() == "Line"){
        Line sketch = new Line(pmouseX, pmouseY, mouseX, mouseY, SizeSlider.getValue(), RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
        Lines.add(sketch);
      }
      
      // Draw with dots
      else if (BrushType.getLabel() == "Dot"){
        Dot spot = new Dot(mouseX, mouseY, SizeSlider.getValue(), RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
        Dots.add(spot);
      }
      
      // Draw with squares
      else if (BrushType.getLabel() == "Square"){
        Square quad = new Square(mouseX, mouseY, SizeSlider.getValue(), RedSlider.getValue(), GreenSlider.getValue(), BlueSlider.getValue(), AlphaSlider.getValue());
        Squares.add(quad);  
      }
    }
  }
}

// Keyboard pressed
void keyPressed() {
  
  // Set timer to 0 to skip waiting:
  if (keyCode == ENTER) {
    startTime -= startTime * 1000;
  }
  
  // Remove 10 seconds to the timer:
  if (keyCode == BACKSPACE) {
    startTime -= 10 * 1000;
  }
  
  // Add 10 seconds to the timer:
  if (key == ' '){
    startTime += 10 * 1000;
  }
}

// Play a piano sound:
public void playPiano(int pitch){
  if (Sound.getLabel() == "Sound"){
    pianoKey[pitch].rewind();
    pianoKey[pitch].play();
  }
}
