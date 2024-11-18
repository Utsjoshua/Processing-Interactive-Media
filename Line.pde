// Line Class
class Line {

  float previousX;
  float previousY;
  float currentX;
  float currentY;
  float velocityX;
  float velocityY;
  
  float size;
  float red;
  float green;
  float blue;
  float alpha;
  
  boolean DrawnOnce = false;
  int sound;
  
  Line(float xprev, float yprev, float xcurr, float ycurr, float Size, float R, float G, float B, float A){
    previousX = xprev;
    previousY = yprev;
    currentX = xcurr;
    currentY = ycurr;
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
  
  // Update the position of the line for animation:
  public void update(){
    previousX += velocityX;
    previousY += velocityY;
    currentX += velocityX;
    currentY += velocityY;
    strokeWeight(size);
    stroke(red, green, blue, alpha);
    fill(red, green, blue, alpha);
    line(previousX, previousY, currentX, currentY);
    
    if (previousX <= 0 || previousX >= width || currentX <= 0 || currentX >= width){
      velocityX *= -1;
      playPiano(sound);

    }
    if (previousY <= 105 || previousY >= height || currentY <= 0 || currentY >= height){
      velocityY *= -1;
      playPiano(sound);
    }
  }
  
  // Show the line on screen:
  public void display(){
    if (!DrawnOnce || Animate.getLabel() == "Freeze"){
      strokeWeight(size);
      stroke(red, green, blue, alpha);
      fill(red, green, blue, alpha);
      line(previousX, previousY, currentX, currentY);
      DrawnOnce = true;
    }
  }
  
}
