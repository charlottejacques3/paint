//Charlotte Jacques
//Block 1-2 B
//Sep 29 2020

color red, orange, yellow, green, blue, indigo, pink, black;
color toolbar, buttonBkgd, selectedColour;
float sliderY, sliderSize, strokeSize, stampSize;
float hueSliderX, hueFloat; 
int hueInt;
PImage cat, eraser, hueBar;
boolean catStamp;

void setup() {//=========================================================================
  size(800, 600);
  background(255);

  //colour variables
  red = #FF0000;
  orange = #FFA500;
  yellow = #FFFF00;
  green = #008000;
  blue = #0000FF;
  indigo = #4B0082;
  pink = #EE82EE;
  black = #000000;

  toolbar = #3C426F;
  buttonBkgd = #E0DCDC;

  selectedColour = black;

  //hue slider variables
  hueBar = loadImage("hue bar.png");
  hueSliderX = 255;
  hueInt = 0;
  hueFloat = 0;

  //eraser
  eraser = loadImage("eraser");

  //stamp variables
  cat = loadImage("cat face.png");
  catStamp = false;

  //thickness slider variables
  sliderY = 52.5;
  sliderSize = 20;
  stampSize = 80;
  strokeSize = 8;
}

void draw() {//==========================================================================
  //toolbar
  colorMode(RGB, 255, 255, 255);
  fill(toolbar);
  noStroke();
  rect(0, 0, 800, 105);
  fill(255);
  
  //new button
  rectButtons(10, 10, 50, 25, 5, buttonBkgd);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(15);
  text("New", 35, 22.5);

  //load button
  rectButtons(10, 40, 50, 25, 5, buttonBkgd); 
  fill(0);
  text("Load", 35, 52.5);
  
  //save button
  rectButtons(10, 70, 50, 25, 5, buttonBkgd);
  fill(0);
  text("Save", 35, 82.5);

  //colour buttons
  colourButtons(90, 30, 20, red);
  colourButtons(135, 30, 20, orange);
  colourButtons(180, 30, 20, yellow);
  colourButtons(225, 30, 20, green);
  colourButtons(90, 75, 20, blue);
  colourButtons(135, 75, 20, indigo);
  colourButtons(180, 75, 20, pink);
  colourButtons(225, 75, 20, black);

  //hue bar
  image(hueBar, 255, 20, 275, 65);
  stroke(0);
  strokeWeight(3);
  line(hueSliderX, 15, hueSliderX, 90);

  //eraser
  rectButtons(540, 22.5, 60, 60, 5, buttonBkgd);
  image(eraser, 540, 22.5, 60, 60);

  //stamp
  rectButtons(620, 10, 80, 85, 5, buttonBkgd);
  image(cat, 620, 10, 80, 85);

  //slider
  stroke(255);
  strokeWeight(1);
  line(730, 15, 730, 90);
  if (mouseY > 15 && mouseY < 90 && mouseX > 720 && mouseX < 740) {
    fill(255);
    circle(730, sliderY, sliderSize);
  } else {
    fill(toolbar);
    circle(730, sliderY, sliderSize);
  }

  //indicator 
  if (catStamp == true) {
    image(cat, 750, 32.5, 50, 50);
  } else if (selectedColour == 255) {
    image(eraser, 750, 32.5, 50, 50);
  } else {
    stroke(selectedColour);
    strokeWeight(strokeSize);
    line(775, 15, 775, 95);
  }
}
//=======================================================================================
void mouseReleased() {
  drawLines();
  hueSlider();
  thicknessSlider();

  //select right colour
  colourSelector(90, 30, 20, red);
  colourSelector(135, 30, 20, orange);
  colourSelector(180, 30, 20, yellow);
  colourSelector(225, 30, 20, green);
  colourSelector(90, 75, 20, blue);
  colourSelector(135, 75, 20, indigo);
  colourSelector(180, 75, 20, pink);
  colourSelector(225, 75, 20, black);
  
  //clear button
  if (mouseX > 10 && mouseX < 60 && mouseY > 10 && mouseY < 35) {
    fill(255);
    noStroke();
    rect(0, 105, 800, 495);
  }
  
  //load button
  if (mouseX > 10 && mouseX < 60 && mouseY > 40 && mouseY < 65) {
    selectInput("Choose an image to load", "loadImage");
  }
  
  //save button
  if (mouseX > 10 && mouseX < 60 && mouseY > 70 && mouseY < 95) {
    selectOutput("Save File", "saveFile");
  }

  //eraser button
  if (mouseX > 540 && mouseX < 600 && mouseY > 22.5 && mouseY < 82.5) {
    selectedColour = 255;
    catStamp = false;
  }

  //cat stamp button
  if (mouseX > 620 && mouseX < 700 && mouseY > 10 && mouseY < 95) {
    catStamp = !catStamp;
  }
}

void mouseDragged() {
  drawLines();
  hueSlider();
  thicknessSlider();
}

void rectButtons(float x, float y, float w, float h, float round, color colour) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    stroke(0);
    strokeWeight(2);
  } else {
    noStroke();
  }

  fill(colour);
  rect(x, y, w, h, round);
}

void colourButtons(float x, float y, float radius, color colour) {
  if (dist(x, y, mouseX, mouseY) < radius) {
    stroke(255);
    strokeWeight(2);
  } else {
    noStroke();
  }

  fill(colour);
  circle(x, y, radius*2);
}

void loadImage(File f) {
  if (f != null) {
    int n = 0;
    while (n < 100) {
      PImage picture = loadImage (f.getPath());
      image(picture, 0, 105);
      n = n + 1;
    }
  }
}

void saveFile(File f) {
  if (f != null) {
    PImage canvas = get (0, 105, width, height - 105);
    canvas.save(f.getAbsolutePath());
  }
}

void colourSelector(float x, float y, float radius, color colour) {
  if (dist(x, y, mouseX, mouseY) < radius) {
    stroke(255);
    strokeWeight(2);
    selectedColour = colour;
    catStamp = false;
  }
}

void drawLines() {
  if (mouseY > 105) {
    if (catStamp == false) {
      stroke(selectedColour);
      strokeWeight(strokeSize);
      line(pmouseX, pmouseY, mouseX, mouseY);
    } else {
      image(cat, mouseX - 40, mouseY - 40, stampSize, stampSize);
    }
  }
}

void hueSlider() {
  //hue slider
  if (mouseX > 255 && mouseX < 530 && mouseY > 15 && mouseY < 90) {
    catStamp = false;
    hueSliderX = mouseX;
    hueFloat = map(hueSliderX, 255, 530, 0, 359);

    //change colour
    colorMode(HSB, 359, 99, 99);
    hueInt = int(hueFloat);
    selectedColour = color(hueInt, 99, 99);
  }
}

void thicknessSlider () {
  if (mouseY > 15 && mouseY < 90 && mouseX > 720 && mouseX < 740) {
    sliderY = mouseY;
    sliderSize = map(sliderY, 15, 90, 10, 30);

    strokeSize = mouseY;
    strokeSize = map(sliderY, 15, 90, 1, 15);

    stampSize = mouseY;
    stampSize = map(sliderY, 15, 90, 40, 120);
  }
}
