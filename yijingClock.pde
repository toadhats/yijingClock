PGraphics mins;
PGraphics hrs;

void setup() {
  size(600, 600);
  background(255);
  imageMode(CENTER); // All images in the sketch are drawn CENTER-wise
  frameRate(1);
  mins = createGraphics(width, height);
  hrs = createGraphics(width, height);
  noFill();
  stroke(100);
  //polygon(5, width/2, height/2, width / 4 * 3, height / 4 * 3, -PI / 2); // Draw a static pentagon as the background
  fill(0);
} // end setup()


void draw() {
  drawMins();
  drawHrs();
}// end draw()


void drawMins() {
  Gua gua = new Gua(minute());
  mins = gua.drawGua();
  image(mins, width/2.0, height/2.0, width/2.5, height/2.5);
}// end drawMins()


void drawHrs() {
  float angle = TWO_PI / 5; // To arrange them in a pentagon
  float startAngle = -PI / 2; // To put the first point at the top
  String binHr = binary(hour() % 12, 5); // Need to convert to 12 hour time, then to a string containting binary representation
  char[] binHrArr = reverse(binHr.toCharArray()); // We're reversing this to match the endianness of the yijing, and the arrangement of a clock.
  println("binary hour = " + binHr);
  hrs = createGraphics(width, height); // Clearing the previous state
  hrs.beginDraw();
  hrs.clear(); // Trying to make the background transparent so we can layer things
  hrs.imageMode(CENTER);

  for (int i = 4; i >= 0; i--) {
    println("Drawing " + binHrArr[i] + " bit at position " + i); // debug
    PGraphics bit = hourBit(binHrArr[i]);
    hrs.image(bit, width/2 + (width/2.1) * cos(startAngle + angle * i), 
      height/2 + (height/2.1) * sin(startAngle + angle * i), 
      25, 25);
  } // end for
  hrs.endDraw();
  image(hrs, width/2, height/2, (width/4)*3, (height/4)*3);
}// end drawHrs()


// Returns a full circle for true and a hollow one for false
PGraphics hourBit(char state) {
  PGraphics bit = createGraphics(40, 40);
  bit.beginDraw(); // Start drawing to this buffer...
  bit.imageMode(CENTER);  
  //bit.clear();
  bit.stroke(0);
  // Fill colour based on state, 1 = filled.
  if (state == '1') {
    bit.fill(0);
  } else {
    bit.fill(255);
  } // end if
  bit.ellipse(20, 20, 30, 30);
  bit.endDraw();
  return bit;
} // end hourBit()


/**
 Copypasted from https://processing.org/tutorials/anatomy/
 Originally i was drawing a pentagon but mainly i jsut needed to learn 
 how to get the coordinates of the points. 
 **/
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