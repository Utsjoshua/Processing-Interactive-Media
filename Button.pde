// Button Class
class Button {
  int x, y, w, h, red, green, blue, outline, size;
  String label;
  
  Button(int xPos, int yPos, int Width, int Height, int Red, int Green, int Blue, int Outline, String Label, int Size){
    x = xPos;
    y = yPos;
    w = Width;
    h = Height;
    red = Red;
    green = Green;
    blue = Blue;
    outline = Outline;
    label = Label;
    size = Size;
  }
  
  Button(){
    x = width/2;
    y = height/2;
    w = 100;
    h = 100;
    red = 0;
    green = 0;
    blue = 0;
    outline = 0;
    label = "Empty";
    size = 20;
  }
  
  // Show the button on screen:
  void display(){
    // Button
    if (checkHover()){
      fill(red + 75, green + 75, blue + 75);
      stroke(red + 20, green + 20, blue + 20);
    }
    else{
      fill(red, green, blue);
      stroke(red - 40, green - 40, blue - 40);
    }
    strokeWeight(outline);
    rect(x-w/2, y, w, h);
    
    // Text
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(size);
    text(label, x, y + h / 2);
  }
  
  // Check if the button has been clicked on:
  boolean checkClick() {
    if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y && mouseY < y + h) {
      return true;
    }
      return false;
  }
  
  // Check if the button has been hovered on:
  boolean checkHover() {
    if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y && mouseY < y + h) {
      return true;
    }
    return false;
  }
  
  // Get the label on the button:
  String getLabel(){
    return label;
  }
  
  // Change the label on the button:
  void ChangeLabel(String text){
    label = text;
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(size);
    text(label, x, y + h / 2);
  }
}
