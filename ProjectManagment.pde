import controlP5.*;
import javax.swing.*;
import processing.core.*;

//icon of the app
public PImage ICON ;
final static String TITLE = "ProjectManagment Idan Kelman";
public JSONObject json;
public ArrayList<NewWindowThing> Displays;

public ArrayList<PImage> Footage;
public ArrayList<Button> Buttons;
public ArrayList<Button> Elements;
public ArrayList<Project> Projects;
public PImage im;
public PImage V;
public PImage clock;
public PImage P;
public PImage M;
public PImage Button_Im;
public PImage Button_Im2;
public PImage [] B;
public PImage [] B2;

public PFont Font;
public PImage Task_T;
public PImage Task;
public ControlP5 cp5;
public Textfield Text_Field; 

public boolean[] Keys;

public final float Btn_rad = 50;
public final float Btn_rad2 = 60;
public final float Btn_rad3 = 40;
public final float Btn_rad4 = 100;
public final float Btn_rad5 = 20;

public Button Plus ;
public Button Minus;
public int Project_Ind =0;
public final color Bacground_C = #15161a;

public int mouseW= 0;
public float Scroll = 40;



//======================================================================================= 
//*initialazing (setup)
//=======================================================================================

void settings() {
  size(562, 1218);
}


void setup()
{
  //2436-by-1125
  //size(1125,2436);
  //size(562, 1218,P2D);
  //size(562, 1218,P2D);
  //size(500, 500);
  //size(displayWidth,displayHeight);
  //orientation(PORTRAIT);


  Load();
  CreateSetup();
  CreateButtons(); 
  CreateProject();

  changeAppIcon( ICON );
  changeAppTitle(TITLE);

 }


//======================================================================================= 
//*main loop (update)
//=======================================================================================

void draw()
{
  background(Bacground_C);
  imageMode(CENTER);
  //image(clock,width/2,height/3.5);
  //textSize(35);
  // text("This is a test",width/2,height/2);
  UpdateStatus();
  ShowProject();
  Show_Btn(Buttons);

  //Show(Elements);
}


//======================================================================================= 
//*psikot(interaptions)
//=======================================================================================

void mousePressed()
{

  Check(Buttons);
  Check_Projects(Projects);
  Check_Field();
  CheckBox();

  //A.Prev.x = random(0,width);
  //A.Prev.y = random(0,height);
}

void keyPressed()
{
  if (keyCode == ENTER && Index!=-1)
  {
    Exec7();
    return;
  }

  if (keyCode==TAB&&cur!=null) 
  {
    Next_Btn();
    return;
  }

  if (keyCode==83)
  { 
    Keys[2]=true;
  }

  if (keyCode==76)
  { 
    Keys[3]=true;
  }
  println(keyCode);

  if (keyCode==CONTROL)          
    Keys[0]=true;

  if (keyCode==BACKSPACE)          
    Keys[1]=true;  


  //add new button;
}

void keyReleased()
{
  //if (keyCode==DELETE)          
  //Keys[1]=true;

  if (Keys[0]==true && Keys[3]==true)
    Load_Project();

  if (Keys[0]==true && Keys[1]==true)
    DeleteProject();

  if (Keys[0]==true && Keys[2]==true)
    Save();

  Keys[0]=Keys[1]=Keys[2]=Keys[3]=false;
}

void mouseWheel(MouseEvent event)
{
  mouseW = event.getCount();
  Scroll();
  //update the current tasks height
  // A.Prev.y+=20*mouseW;
}
