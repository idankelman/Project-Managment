
//======================================================================================= 
//*Creating (setup) function
//=======================================================================================
public Project cur;
public int Index=-1;
public Button INC;

public void CreateSetup()
{
  Buttons = new ArrayList<Button>();
  Elements=new  ArrayList<Button>();
  Projects=new  ArrayList<Project>();
  Footage = new ArrayList<PImage>();
  Displays =new ArrayList<NewWindowThing>();
  cp5 = new ControlP5(this);
  Text_Field = cp5.addTextfield("---------Enter Your Text Here ---------").setColorBackground(Bacground_C).setColorForeground(color(40, 40, 70)).setFont(Font).setSize((int)Btn_rad4*2, (int)Btn_rad4/4).setPosition(width/2-Btn_rad4, height/24)
    .setLabelVisible(false).lock().setAutoClear(false).setColorCaptionLabel(color(255, 255, 255)).setColorValue(color(255, 255, 255)).setColor(color(255, 255, 255));

  Keys = new boolean[4];  

  // Text_Field.setImage(Button_Im2);

  //textFont(Font);
}

public void CreateButtons()
{
  Plus = new Button(width/2, height/6, Btn_rad5);
  Plus.ID= 13;
  Minus = new Button(width/2, height/6, Btn_rad5);
  Minus.ID =14;
  Plus.Circ=true;
  Minus.Circ=true;
  Minus.Rect= false;
  Plus.Rect=false;
  Plus.minA=0;
  Minus.minA=0;
  Plus.lerpSpeed=0.1;
  Minus.lerpSpeed=0.1;
  Minus.Im=M;
  Plus.Im=P;
  Plus.Lerp_Color=false;
  Minus.Lerp_Color=false;

  //Minus.Visable=false;
  //Plus.Visable=false;



  int ID =9;
  float x = Btn_rad*1.5;
  float spacing = (width)/4; 
  x-=spacing;
  float y = height-height/30;

  for (int i =0; i<4; i++)
  {
    Button tmp = new Button(x+=spacing, y, Btn_rad2);
    tmp.ID=ID;
    ID++;
    tmp.Sqr=true;
    tmp.Rect=false;
    tmp.Im=B[i];
    tmp.Transparent = true;
    tmp.minA=0;

    //tmp.C=color(25,25,25);
    Buttons.add(tmp);
  }
  Buttons.add(Plus);
  Buttons.add(Minus);

  //aButtons.add(A);
}

public void CreateProject()
{
  Projects.add(new Project("Test"));
  cur = Projects.get(0);
}

public void Load()
{
  clock=loadImage("clock2_S.png"); 
  Task=loadImage("Task_S.png"); 
  Task_T=loadImage("Task_Top_S.png"); 
  Font= createFont("Font.ttf", 10);
  V= loadImage("V2.png");
  P=loadImage("Plus.png");
  M=loadImage("Minus.png");
  Button_Im= loadImage("Button_S.png");
  Button_Im2= loadImage("Button2_S.png");

  B2= new PImage[4];
  B2[0]= loadImage("Btn_9_N.png");
  B2[1]= loadImage("Btn_10_N.png");
  B2[2]= loadImage("Btn_11_N.png");
  B2[3]= loadImage("Btn_12_N.png");

  B= new PImage[4];
  B[0]= loadImage("Btn_9_S.png");
  B[1]= loadImage("Btn_10_S.png");
  B[2]= loadImage("Btn_11_S.png");
  B[3]= loadImage("Btn_12_S.png");

  ICON =  loadImage("Icon.png");

  textFont(Font);
}


void changeAppIcon(PImage img) {
  final PGraphics pg = createGraphics(16, 16, JAVA2D);

  pg.beginDraw();
  pg.image(img, 0, 0, 16, 16);
  pg.endDraw();

  surface.setIcon(img);
}

void changeAppTitle(String title) {
  surface.setTitle(title);
}

//======================================================================================= 
//*Show Functions
//=======================================================================================


public void Show_Btn(ArrayList<Button>A)
{

  for (int i =0; i<A.size(); i++)
    A.get(i).Show();
}

public void ShowProject()
{
  cur.Show();
}

public void Show_Tasks()
{

  //tint(0);
  int size = -1;
  if ( Index!=-1)
    size = cur.Arr.get(Index).size()-1;
  if (size!=-1)
  {
    tint(255, cur.Arr.get(Index).get(size).alpha);
    for (int i =0; i<4; i++)
    {
      Buttons.get(i).alpha=cur.Arr.get(Index).get(size).alpha;
      if (Buttons.get(i).alpha<40)
        Buttons.get(i).Visable=false;
      else
        Buttons.get(i).Visable=true;
    }
  }
  // noTint();
  image(Task, width/2, height-Task.height/2);
  // noTint();
  // noTint();
}

//======================================================================================= 
//*check Functions(<T> pressed)
//=======================================================================================

public void Check(ArrayList<Button> A)
{
  for (int i =0; i<A.size(); i++)
  {
    Button temp = A.get(i);
    if (temp.Pressed() == true)
      Execute(temp.ID);
  }
}

public void Check_Projects( ArrayList<Project> A)
{
  for (int i =0; i<A.size(); i++)
  {
    Project temp = A.get(i);
    if (temp.Visable == true)
    {  
      Project_Ind = i;
      cur = Projects.get(Project_Ind);
      Check(temp.B);
      return;
    }
  }
}

//checks if we can add new textfiles/pdfs
public int Check_Pressed()
{
  for (int i =0; i<cur.Vis.length; i++)
    if (cur.Vis[i]==1)
      return i;

  return -1;
}

public void CheckBox()
{

  int ind = Check_Pressed();
  if (ind==-1)
    return;
  int t =  cur.Arr.get(ind).size();
  if (t==0)
    return;
  for (int i =0; i<t; i++)
  {
    Button temp=  cur.Arr.get(ind).get(i);
    if (temp.Pressed()==true&& mouseButton==RIGHT)
    {
      if (temp.Im==null)
      {
        temp.Marked = true;
        temp.Im= V;
      } else
      {
        temp.Im=null;
        temp.Marked = false;
      }
    }
    if (temp.Pressed()==true && mouseButton==LEFT)
    {
      temp.Pressed=!temp.Pressed;
      MoveButtons(temp, temp.Pressed);
      INC=temp;
    }
  }
}

public void Check_Field()
{

  Index = Check_Pressed();
  if (Index==-1)
  {
    Text_Field.lock();
  } else
    Text_Field.unlock();
}

public void Next_Btn()
{
  if (Index==-1)
  {
    Index=0;
    cur.Vis[Index]=1;
    return;
  }

  cur.Vis[Index]=0;
  Index++;
  if (Index==cur.Vis.length) 
    Index=0;
  cur.Vis[Index]=1;
}

public void  CheckDate(int inc)
{
  cur.Date[0]+=inc;

  if (cur.Date[0]>31)
  {
    cur.Date[0]=0;
    cur.Date[1]++;
  }
  if (cur.Date[0]<0)
  {
    cur.Date[0]=31;
    cur.Date[1]--;
  }
  if (cur.Date[1]<0)
  {
    cur.Date[2]--;
    cur.Date[1]=12;
  }
  if (cur.Date[1]>12)
  {
    cur.Date[2]++;
    cur.Date[1]=0;
  }
}

public void UpdateStatus()
{

  if (cur.Arr.size()==0)
    return;
  int i=0;
  for (ArrayList<Button> B : cur.Arr)
  {
    cur.Progress.F[i]=Status(B);
    i++;
  }
}


public int Status(ArrayList<Button> A)
{
  if (A.size()==0)
    return 0;

  int count = 0;
  for (int i =0; i<A.size(); i++)
  {
    if (A.get(i).Im!=null)
      count++;
  }
  return count;
}

public void Scroll()
{

  if (Index==-1)
    return;
  float Top = cur.y;
  float Bottom = height-Task.height;
  for (int i =0; i<cur.Arr.get(Index).size(); i++)
  {
    Button tmp =  cur.Arr.get(Index).get(i);
    tmp.Prev.y+= mouseW*Scroll;
    if (tmp.Prev.y<=Top||tmp.Prev.y>=Bottom)
      tmp.Lerp_Color=false;
    else
      tmp.Lerp_Color=true;
  }
}


public void MoveButtons(Button B, boolean T)
{

  float offset = Minus.Rad*2 + B.Rad/2;
  if (T==true)
  {
    Minus.Prev.x = B.Pos.x+offset;
    Minus.Prev.y = B.Pos.y+offset/4;
    Plus.Prev.x = B.Pos.x+offset;
    Plus.Prev.y= B.Pos.y-offset/4;
    Minus.Lerp_Color=true;
    Plus.Lerp_Color=true;
    Minus.Pressable= true;
    Plus.Pressable= true;
    //Minus.Visable=true;
    //Plus.Visable = true;
  }
  if (T==false)
  {
    Minus.Lerp_Color=false;
    Plus.Lerp_Color=false;
    Plus.Prev.x-=offset;
    Minus.Prev.x-=offset;
    Minus.Pressable= false;
    Plus.Pressable= false;
    //Minus.Visable=false;
    //Plus.Visable = false;
  }
}



//======================================================================================= 
//*Executions depending on which id of button was pressed
//=======================================================================================

public boolean Execute( int ID )
{
  //example
  if (ID==1)
  {
    println("Preesed");
    return Exec1();
  }

  if (ID==2)
  {   
    println("Preesed");
    return Exec2();
  }

  if (ID==3)
  {
    println("Preesed");
    return Exec3();
  }

  if (ID==4)
  {
    println("Preesed");
    return Exec4();
  }

  if (ID==5)
  {
    println("Preesed");
    return Exec5();
  }

  if (ID==6)
  {
    println("Preesed");
    return Exec6();
  }

  if (ID==7)
  {
    println("Preesed");
    return Exec7();
  }
  if (ID==8)
  {
    println("Preesed");
    return Exec8();
  }
  if (ID==9)
  {
    println("Preesed");
    return Exec9();
  }
  if (ID==10)
  {
    println("Preesed");
    return Exec10();
  }

  if (ID==11)
  {
    println("Preesed");
    return Exec11();
  }
  if (ID==12)
  {
    println("Preesed");
    return Exec12();
  }
  if (ID==13)
  {
    println("Preesed");
    return Exec13();
  }
  if (ID==14)
  {
    println("Preesed");
    return Exec14();
  }

  return false;
}


//======================================================================================= 
//*the Execution Fucntions
//=======================================================================================





//*the progress exec functions
//=======================================================================================


public boolean Exec1()
{

  if (cur.Vis[0]==1)
    cur.Vis[0]=0;
  else
    cur.Vis[0]=1;

  for (int i=0; i<cur.Vis.length; i++)
    if (i!=0)
      cur.Vis[i]=0;


  return true;
}

public boolean Exec2()
{
  if (cur.Vis[1]==1)
    cur.Vis[1]=0;
  else
    cur.Vis[1]=1;

  for (int i=0; i<cur.Vis.length; i++)
    if (i!=1)
      cur.Vis[i]=0;
  return true;
}

public boolean Exec3()
{
  if (cur.Vis[2]==1)
    cur.Vis[2]=0;
  else
    cur.Vis[2]=1;

  for (int i=0; i<cur.Vis.length; i++)
    if (i!=2)
      cur.Vis[i]=0;
  return true;
}

public boolean Exec4()
{
  if (cur.Vis[3]==1)
    cur.Vis[3]=0;
  else
    cur.Vis[3]=1;

  for (int i=0; i<cur.Vis.length; i++)
    if (i!=3)
      cur.Vis[i]=0;
  return true;
}


//*the Date
//=======================================================================================


public boolean Exec5()
{
  cur.Sced.Lerp_Color=!cur.Sced.Lerp_Color;
  cur.Sced.Pressed=!cur.Sced.Pressed;
  MoveButtons(cur.Sced, cur.Sced.Pressed);
  INC=cur.Sced;
  return true;
}


//pressed on the CheckBox Button()
public boolean Exec6()
{


  return true;
}


////for adding new text
//=======================================================================================
public boolean Exec7()
{

  Button t;
  int ind =0;
  for (; ind<cur.Vis.length; ind++)
    if (cur.Vis[ind]==1)
      break;
  int size=cur.Arr.get(ind).size()-1;
  println(size);

  if (size==-1)
    t  =new Button(width/7 + Btn_rad3/2, cur.Idea.Pos.y+Btn_rad3*2, Btn_rad3);
  else
    t  =new Button(width/7 + Btn_rad3/2, (cur.Arr.get(ind).get(size).Prev.y)+Btn_rad3*2, Btn_rad3);  


  t.ID=6;
  t.Rect=false;
  t.Sqr=true;
  t.fill=false;
  t.C= color(255, 255, 255);
  t.T= Text_Field.getText();
  t.minA=0;
  Text_Field.setText("");


  //get the new text that you want to add

  cur.Arr.get(ind).add(t);




  return true;
}


//for adding new file
//============================================
public boolean Exec8()
{

  Button t;
  int ind =0;
  for (; ind<cur.Vis.length; ind++)
    if (cur.Vis[ind]==1)
      break;

  int size=cur.Arr.get(ind).size()-1;
  println(size);

  //if (size==-1)
  //t  =new Button(width/7 + Btn_rad2/2, cur.Idea.Pos.y+Btn_rad2*2, Btn_rad2);
  // else
  t  =new Button(width/7 + Btn_rad2/2, (cur.Arr.get(ind).get(size).Prev.y)+Btn_rad2*2, Btn_rad2);


  t.ID=6;
  t.Rect=false;
  t.Sqr=true;
  t.fill=false;
  t.minA=0;
  t.C= 255;

  //get the new File that you want to add

  cur.Arr.get(ind).add(t);
  return true;
}

//creating new project(main menue
public boolean Exec9()
{

  final String id =JOptionPane.showInputDialog("Please enter new project name");
  if (id==null)
    return false;
  Project p = new Project(id);
  Text_Field.clear();
  p.Visable= false;
  Projects.add(p);
  MoveButtons(new Button(width/2, height/2, 2), false);


  if (Buttons.get(0).Im==B[0])
    Buttons.get(0).Im=B2[0];

  else
    Buttons.get(0).Im=B[0];


  return true;
}


//move between Projects
public boolean Exec10 ()
{
  println("10");
  Projects.get(Project_Ind).Visable=false;
  if (Project_Ind+1==Projects.size())
  {
    Project_Ind=-1;
  }
  Projects.get(Project_Ind+1).Visable=true;
  if (Project_Ind==-1)
    Project_Ind++;
  MoveButtons(new Button(width/2, height/2, 2), false);


  if (Buttons.get(1).Im==B[1])
    Buttons.get(1).Im=B2[1];

  else
    Buttons.get(1).Im=B[1];

  return true;
}

//Show Progress
public boolean Exec11()
{
  cur.Progress.Visable=!cur.Progress.Visable;
  cur.Progress.Lerp_Progress=!cur.Progress.Lerp_Progress;
  cur.Sced.Lerp_Color=!cur.Sced.Lerp_Color;
  //cur.Sced.Visable=!cur.Sced.Visable;
  cur.Sced.Pressable=!cur.Sced.Pressable;

  if (Buttons.get(2).Im==B[2])
    Buttons.get(2).Im=B2[2];

  else
    Buttons.get(2).Im=B[2];
  return true;
}


//show files
public boolean Exec12()
{
  if (Buttons.get(3).Im==B[3])
    Buttons.get(3).Im=B2[3];

  else
    Buttons.get(3).Im=B[3];


  for ( NewWindowThing tmp : Displays)
  {
    tmp.close=true;
    Displays.remove(tmp);
    return true;
  }

  for (PImage P : Footage)
  {
    NewWindowThing tmp = new NewWindowThing(new PVector(mouseX, mouseY), this); // Create brand new instance of second window
    String[] args = {"Figure ####"};
    tmp.Im= P;
    PApplet.runSketch(args, tmp);
    Displays.add(tmp);// Run it.
  }
  return true;
}

//======================================================================================= 
//*the Plus/Minus Execution Fucntions
//=======================================================================================


//plus
public boolean Exec13()
{
  if (INC==null)
    return false;
  //if the dec is on textBox
  if (INC.ID==6) 
    cur.Arr.get(Index).remove(cur.Arr.get(Index).size()-1);

  if (INC.ID==5) 
    CheckDate(1);
  return true;
}

//minus
public boolean Exec14()
{
  if (INC==null)
    return false;
  //if the dec is on textBox
  if (INC.ID==6&&cur.Arr.get(Index).size()>0) 
  {
    cur.Arr.get(Index).remove(INC);
    INC=null;
    return true;
  }
  if (INC.ID==5)
    CheckDate(-1);
  return true;
}

//========================================================================================================================================
//Delte project
//========================================================================================================================================

void DeleteProject()
{
  int A =JOptionPane.showConfirmDialog(null, "Are you sure you want to delete "+cur.Name +" project?", "Deleting project:", JOptionPane.YES_NO_OPTION);
  if (A== JOptionPane.NO_OPTION)
    return;
  if ( Projects.size()<=1 )
    while (Exec9()==false)
      Exec9();

  int ind = Project_Ind-1;
  if (ind==-1)
    ind = 0;

  //cur.Visable= true;
  Projects.remove(Project_Ind);
  Project_Ind=ind;
  Projects.get(ind).Visable=true;
  cur=Projects.get(ind);  
  MoveButtons(new Button(width/2, height/2, 2), false);
}

//========================================================================================================================================
//Load Project
//========================================================================================================================================


void Load_Project()
{
  final String id =JOptionPane.showInputDialog("Please enter new project file name (without .json)");
  if (id==null)
    return ;

  try {
    JSONObject json = loadJSONObject("Projects/"+id+".json");
  }
  catch(Exception e )
  {
    try {
      Footage.add(loadImage("Footage/"+id+".png"));
      return;
    }
    catch(Exception e2)
    {
      JOptionPane.showMessageDialog(null, "Could not open file", "Error", JOptionPane.ERROR_MESSAGE);
      return;
    }
  }
  JSONObject json = loadJSONObject("Projects/"+id+".json");
  JSONArray T = json.getJSONArray("Arr");
  ArrayList<ArrayList<Button>> ARR = new ArrayList<ArrayList<Button>>();
  String name = json.getString("Name");


  for (int k = 0; k<T.size(); k++)
  {
    JSONObject Arr = T.getJSONObject(k);
    JSONArray Buttons = Arr.getJSONArray("Button"+k);

    ArrayList<Button> BUTTONS = new ArrayList<Button>();

    for (int j = 0; j <Buttons.size(); j++)
    {
      JSONObject Btn = Buttons.getJSONObject(j);
      float x = Btn.getFloat("x");
      float y = Btn.getFloat("y");
      String Txt = Btn.getString("T");
      boolean Marked = Btn.getBoolean("Marked");
      int ID = Btn.getInt("ID");

      Button tmp  =new Button(x, y, Btn_rad3);
      tmp.Marked= Marked;
      if (tmp.Marked == true)
        tmp.Im = V;
      tmp.T= Txt;
      tmp.ID = ID;
      //tmp.ID=6;
      tmp.Rect=false;
      tmp.Sqr=true;
      tmp.fill=false;
      tmp.C= color(255, 255, 255);
      tmp.minA = 0;
      BUTTONS.add(tmp);
    }
    ARR.add(BUTTONS);
  }


  println(ARR.size());

  Project p = new Project(name);
  p.Arr= ARR;

  p.B1 = ARR.get(0);
  p.B2 = ARR.get(1);
  p.B3 = ARR.get(2);
  p.B4 = ARR.get(3);


  Projects.add(p);
}

//saving the project
//===================================================================================================
void Save()
{
  final String id =JOptionPane.showInputDialog("Save File_Name As:");
  if (id==null)
    return ;

  json = new JSONObject();
  //JSONArray weights = new JSONArray();
  JSONArray T = new JSONArray();
  // JSONObject perceptron_brain= new JSONObject();

  for (int k = 0; k<cur.Arr.size(); k++)
  {
    JSONObject Arr = new JSONObject();
    JSONArray Buttons = new JSONArray();
    ArrayList<Button> temp = cur.Arr.get(k);
    for (int j = 0; j <temp.size(); j++)
    {
      JSONObject Button = new JSONObject();
      Button.setString("T", temp.get(j).T);
      Button.setFloat("x", temp.get(j).Prev.x);
      Button.setFloat("y", temp.get(j).Prev.y);
      Button.setBoolean("Marked", temp.get(j).Marked);
      Button.setInt("ID", temp.get(j).ID);
      Buttons.setJSONObject(j, Button);
    }
    Arr.setJSONArray("Button"+k, Buttons);
    T.setJSONObject(k, Arr);
  }

  //saving the Hidden layers -----------------

  json.setJSONArray("Arr", T);
  json.setString("Name", cur.Name);

  saveJSONObject(json, "Projects/"+id+".json");
}




//========================================================================================================================================
//
//========================================================================================================================================
