// Dot Class
class Dot {
  float positionX;
  float positionY;
  float velocityX;
  float velocityY;
  
  float size;
  float red;
  float green;
  float blue;
  float alpha;
  
  int sound;
  boolean DrawnOnce = false;
  
  Dot(float Xpos, float Ypos, float Size, float R, float G, float B, float A){
    positionX = Xpos;
    positionY = Ypos;
    velocityX = random(-1, 1);
    velocityY = random(-1, 1);
    size = Size;
    red = R;
    green = G;
    blue = B;
    alpha = A;
    
    // Depending on the colour's brightness, the pitch of its piano will be different.
    sound = Math.round(map(((red + green + blue) / 3), 0, 255, 0, 7));
  }
  
  // Update the position of the dot for animation:
  public void update(){
    positionX += velocityX;
    positionY += velocityY;
    strokeWeight(size);
    stroke(red, green, blue, alpha);
    fill(red, green, blue, alpha);
    
    if (size == 0){
      ellipse(positionX, positionY, 0.5, 0.5);
    }
    else {
      ellipse(positionX, positionY, size, size);
    }
    
    if (positionX <= 0 || positionX >= width){
      velocityX *= -1;
      playPiano(sound);
    }
    if (positionY <= 105 || positionY >= height){
      velocityY *= -1;
      playPiano(sound);
    }
  }
  
  // Show the dot on screen:
  public void display(){
    if (!DrawnOnce || Animate.getLabel() == "Freeze"){
      stroke(red, green, blue, alpha);
      fill(red, green, blue, alpha);
      
      if (size == 0){
        ellipse(positionX, positionY, 0.5, 0.5);
      }
      else {
        ellipse(positionX, positionY, size, size);
      }
      
      DrawnOnce = true;
    }
  }
}