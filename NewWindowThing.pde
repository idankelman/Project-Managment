class NewWindowThing extends PApplet {

  PVector coolThing;
  PImage Im;
  int sizex=1920/2;
  int sizey=1080/2;
  float prevx=0;
  float prevy=0; 
  float start=prevx;
  float end=prevy;
  float curx;
  float cury;
  float s=1;
  boolean close = false;
  ProjectManagment parent; // "myClass" refers to the class of the parent sketch, if testing in Processing rename to your project's name


  NewWindowThing(PVector myCoolThing, ProjectManagment myParent) { // "myClass" refers to the class of the parent sketch, if testing in Processing rename to your project's name

    coolThing = myCoolThing;
    parent = myParent;
  }

  void settings() {
    size(1920/2, 1080/2); //Don't set this to P2D - if you do, closing main window will make a ThreadDeath.
    // surface.setResizable(true);
  }
  void setup() {
    surface.setTitle("Figure###");
    //centerImage();
  }
  void draw() {
    background(Bacground_C);
    fill(255);
    // imageMode(CORNER);
    scale(s);
    translate(start, end);
    image(Im, 0, 0, sizex, sizey);

    if (close == true)
      this.stop();
  }
  void mouseWheel(MouseEvent event)
  {
    s -= event.getCount();
    if (s<=0)
      s=1;
  }
  // mousepressed
  void mousePressed()
  {
    // set variables for holding mouseposition offset
    // to the image
    //prevx = (mouseX-start)/s;
    //prevy = (mouseY-end)/s;


    prevx= mouseX;
    prevy = mouseY;
  }

  void mouseDragged()
  {
    //start = (mouseX-prevx)/s;
    //end = (mouseY-prevy)/s;

    curx = mouseX;
    cury = mouseY;
    float xShift = curx - prevx;
    float yShift = cury - prevy;
    start +=  xShift/s;
    end +=  yShift/s;
    prevx = curx;
    prevy = cury;

    //start = int(constrain(start, s * (width - sizex), 0));
    //end = int(constrain(end, s * (height - sizey), 0));
  }

  // any key pressed, will re-center the image
  void keyPressed()
  {
    if (key== ESC)
    {
      this.stop();
      key = 0;
      
    }

    centerImage();
  }

  // center image function
  void centerImage()
  {
    start = 0;
    end= 0;
    s =1;
  }
}
