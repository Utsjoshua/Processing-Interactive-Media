// Slider Class
class Slider {
  float x, y, w, h;
  float minVal, maxVal;
  float currentVal;
  boolean dragging;
  int red, green, blue;
  
  Slider(float x, float y, float w, float h, float minVal, float maxVal, float current, int Red, int Green, int Blue) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.minVal = minVal;
    this.maxVal = maxVal;
    this.currentVal = current;
    this.dragging = false;
    this.red = Red;
    this.green = Green;
    this.blue = Blue;
  }
  
  Slider(){
    x = width/2;
    y = height/2;
    w = 100;
    h = 10;
    minVal = 0;
    maxVal = 100;
    currentVal = 50;
    dragging = false;
  }
  
  // Update the position of the slider to the mouse position:
  void update() {
    if (dragging) {
      currentVal = map(mouseX, x, x + w, minVal, maxVal);
      currentVal = constrain(currentVal, minVal, maxVal);
    }
  }
  
  // Show the slider on screen:
  void display() {
    
    // Background rectangle
    stroke(0);
    fill(200);
    rect(x, y, w, h);
    
    // Handle
    float handleX = map(currentVal, minVal, maxVal, x, x + w);
    fill(red, green, blue);
    rect(handleX -5, y - 5, 15, h + 10);
  }
  
  // Enable the dragging of handle:
  void pressed() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      dragging = true;
    }
  }
  
  // Disable the dragging of handle:
  void released() {
    dragging = false;
  }
  
  // Get the value of the slider:
  float getValue() {
    return currentVal;
  }
}
