PGraphics mins;
PGraphics hrs;

void setup() {
  //noLoop(); // testing
  size(400, 400);
  background(255);
  
  frameRate(1);
  mins = createGraphics(300, 300);
  hrs = createGraphics(300, 300);
  noFill();
  stroke(85);
  polygon(5, 200, 200, 300, 300, -PI / 2);
  fill(0);
}

void drawMins() {
  Gua gua = new Gua(minute());
  mins = gua.drawGua();
  
}// end drawMins()

// Returns a full circle for true and a hollow one for false
PGraphics hourBit(boolean state) {
  PGraphics bit = createGraphics(50, 50);
  bit.beginDraw(); // Start drawing to this buffer...
  stroke(0);
  // Fill colour based on state
  if (state == true) {
    fill(0);
  } else {
    fill(255);
  } // end if
  ellipse(25, 25, 50, 50);
  bit.endDraw();
  return bit;  
} // end hourBit()

// Copypasted from https://processing.org/tutorials/anatomy/
void polygon(int n, float cx, float cy, float w, float h, float startAngle) {
  float angle = TWO_PI/ n;

  // The horizontal "radius" is one half the width,
  // the vertical "radius" is one half the height
  w = w / 2.0;
  h = h / 2.0;

  beginShape();
  for (int i = 0; i < n; i++) {
    vertex(cx + w * cos(startAngle + angle * i), 
      cy + h * sin(startAngle + angle * i));
  }
  endShape(CLOSE);
}