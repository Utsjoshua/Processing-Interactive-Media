// Text Class
class Text{
  int x, y, size;
  String label;
  int variable;
  
  Text(int xPos, int yPos, String Label, int Size, int Variable){
    x = xPos;
    y = yPos;
    label = Label;
    size = Size;
    variable = Variable;
  }
  
  Text(int xPos, int yPos, String Label, int Size){
    x = xPos;
    y = yPos;
    label = Label;
    size = Size;
    variable = -1;
  }
  
  Text(){
    x = width/2;
    y = height/2;
    label = "Empty";
    size = 20;
    variable = 0;
  }
  
  // Show the text on screen
  void display(){
    
    // Text
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(size);
    if (variable >= 0){
      text((label + variable), x, y);
    }
    else{
      text((label), x, y);
    }
  }
  
  // Change the text's variable
  void changeVariable(int newVariable){
    variable = newVariable;
  }
}
