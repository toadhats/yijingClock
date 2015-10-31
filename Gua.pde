// static final int fadeMax = 2880; //1440 means 1 step per frame takes 1 minute at 24fps
// Copying that there is a bad approach tbh

class Gua {
  int[] yao = new int[6];
  PImage img;
  int intValue = 0; // Used to cast the binary to base 10 to represent the hexagram that way
  static final int height = 300;
  static final int width = 300;
  static final int lineHeight = height / 12; // the height of a line; voids are equal height to lines
  static final int segmentSize = width / 5; // Used to determine the ratio of line to white in yin line; must be an odd number to allow middle to be empty

  private int x = 0; // remember that (0,0) is the top left corner. Not using x really.
  private int y = 0; // Used when moving down the hexagram while drawing it



  // Default constructor instantiates a random hexagram
  Gua() {
    for (int i = 0; i < 6; i++) {
      yao[i] = round(random(0, 1));
      print(yao[i]);
    }
    println();
  } // end Gua()

  // Construct a hexagram with a given (base 10) value.
  Gua(int value) {
    String binary = binary(value, 6);
    //println("parsed binary: " + binary);
    for (int i = 0; i < binary.length(); i++) {
      yao[i] = Character.getNumericValue(binary.charAt(i));
      print(yao[i]);
    }    
    println();
  } // end Gua(int)

  // Returns an image representation of the hexagram
  PGraphics drawGua() {

    PGraphics pg = createGraphics(width, height); // the image buffer we will return
    pg.beginDraw();
    //pg.clear();
    pg.fill(0);
    //pg.background(255);
    int i = 5; // we have to read them backwards because tradition places the "smallest bit" at the top

    for (y = 0; y <= 250; y = y + 50) {
      if (yao[i] == 0) { // yin        
        pg.rect(x, y, (segmentSize * 2), lineHeight); // left side
        pg.rect(segmentSize * 3, y, (segmentSize * 2), lineHeight); // right side
        println("-- --");
      } // end if
      else { // yang
        pg.rect(x, y, width, lineHeight);
        println("-----");
      } // end else
      i--;
    } //end for
    pg.endDraw();
    return pg;
  } // end drawGua()
/** Draw a gua of a given colour **/
  PGraphics drawGua(color col) {

    PGraphics pg = createGraphics(width, height); // the image buffer we will return
    pg.beginDraw();
    //pg.clear();
    pg.noStroke();
    pg.fill(col);
    //pg.background(255, alpha(col));
    int i = 5; // we have to read them backwards because tradition places the "smallest bit" at the top

    for (y = 0; y <= 250; y = y + 50) {
      if (yao[i] == 0) { // yin        
        pg.rect(x, y, (segmentSize * 2), lineHeight); // left side
        pg.rect(segmentSize * 3, y, (segmentSize * 2), lineHeight); // right side
        println("-- --");
      } // end if
      else { // yang
        pg.rect(x, y, width, lineHeight);
        println("-----");
      } // end else
      i--;
    } //end for
    pg.endDraw();
    return pg;
  }// end drawGua(colour)


  String toString() {
    return join(str(yao), "");
  }// end toString()

  int toInt() {
    return unbinary(toString());
  }// end toInt()
} // End Gua