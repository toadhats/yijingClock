/**
A cool clock. Tests some concepts I've been unsure about.

It might be nice to use a trochoid curve thing to make the image fade in and out over the minute?
A cool effect maybe, but also not necessarily very clock-like.
Save for v2, where i could work the layering out properly so the fading is more intuitive
**/
PGraphics mins;
PGraphics hrs;
float fadeAmount;
static final float fadeMax = 1440; //1440 means 1 step per frame takes 1 minute at 24fps

void setup() {
  size(500, 500);
  colorMode(RGB, 255, 255, 255, fadeMax);
  background(255);
  imageMode(CENTER); // All images in the sketch are drawn CENTER-wise
  frameRate(24); // Affects the smoothness and speed of fade();
  mins = createGraphics(width, height);
  hrs = createGraphics(width, height);
  noFill();
  stroke(100);
  //polygon(5, width/2, height/2, width / 4 * 3, height / 4 * 3, -PI / 2); // Draw a static pentagon as the background
  fill(0);
  fadeAmount = 0;
} // end setup()


void draw() {
  //let's fade instead of redrawing the background to expose change over time
  fadeAmount = map(System.currentTimeMillis() % 60000, 0, 60000, 1, fadeMax); // new way explicitly ties the fade amount to the real current second
  //println(fadeAmount);
  fade(fadeAmount);

  drawMins();
  drawHrs();
}// end draw()


void drawMins() {
  Gua gua = new Gua(minute());
  mins = gua.drawGua(color(0, 0, 0, constrain(fadeAmount*2, 100, fadeMax)));
  image(mins, width/2.0, height/2.0, width/2.5, height/2.5);
}// end drawMins()


void drawHrs() {
  float angle = TWO_PI / 5; // To arrange them in a pentagon
  float startAngle = -PI / 2; // To put the first point at the top
  String binHr = binary(hour(), 5); // Use modulo 12 if we want 12 hour time, but that's a waste of bits imo
  char[] binHrArr = reverse(binHr.toCharArray()); // We're reversing this to match the endianness of the yijing, and the arrangement of a clock.
  hrs = createGraphics(width, height); // Clearing the previous state
  hrs.beginDraw();
  hrs.clear(); // Trying to make the background transparent so we can layer things
  hrs.imageMode(CENTER);

  for (int i = 4; i >= 0; i--) {
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
    bit.fill(0, fadeAmount); // They fade in
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

/**
 Draws a semitransparent background, which fades everything on
 screen by a given amount
 **/
void fade(float amount) {
  fill(255, amount); // hardcoding bc 1. im lazy, and 2. this sketch should always be b/w
  rectMode(CENTER);
  rect(width/2, height/2, width, height);
}// end fade