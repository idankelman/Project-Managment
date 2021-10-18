class Project
{
  public Button Idea;
  public Button Prep;
  public Button Exec;
  public Button Finish;
  public Button Sced;
  public Progress Progress;

  public ArrayList<Button> B;
  public ArrayList<Button> B1;
  public ArrayList<Button> B2;
  public ArrayList<Button> B3;
  public ArrayList<Button> B4;

  public ArrayList<ArrayList<Button>> Arr;

  public int[] Vis ;
  public String Name;
  public int[] Date;
  boolean Visable = true;

  public float y;
  public float x;


  public Project(String name )
  {

    y = height/3;
    float spacing = (width-Btn_rad*4)/4.2;
    x =0;


    Progress = new Progress(width/1.95, height/5.15, width/3.5);


    Date=new int[] {day(), month(), year()};
    Vis = new int[]{0, 0, 0, 0};

    B= new ArrayList<Button>();
    B1= new ArrayList<Button>();
    B2= new ArrayList<Button>();
    B3= new ArrayList<Button>();
    B4= new ArrayList<Button>();

    Arr= new ArrayList<ArrayList<Button>>();
    Arr.add(B1);
    Arr.add(B2);
    Arr.add(B3);
    Arr.add(B4);



    this.Name = name;
    this.Idea = new Button(x+=spacing, y, Btn_rad);
    spacing+=Btn_rad/2;
    this.Prep = new Button(x+=spacing, y, Btn_rad);
    spacing-=Btn_rad/2;
    this.Exec = new Button(x+=spacing+Btn_rad*2, y, Btn_rad);
    spacing+=Btn_rad/2;
    this.Finish = new Button(x+=spacing, y, Btn_rad);


    this.Sced = new Button(width/1.95, height/5.15, width/3.5);
    this.Sced.Circ = true;
    this.Sced.Rect= false;
    this.Sced.Im= clock;

    Idea.ID=1;
    Prep.ID=2;
    Exec.ID=3;
    Finish.ID=4;
    Sced.ID=5;
    Sced.minA=0;

    Idea.S="idea";
    Prep.S="Preperation";
    Exec.S="Execution";
    Finish.S="Finish";

    Idea.Im= Button_Im;
    Exec.Im= Button_Im;
    Prep.Im= Button_Im;
    Finish.Im= Button_Im;

    Idea.Transparent= true;
    Exec.Transparent= true;
    Prep.Transparent= true;
    Finish.Transparent= true;

    Idea.minA= 40;
    Exec.minA= 40;
    Prep.minA= 40;
    Finish.minA= 40;




    B.add(Idea);
    B.add(Prep);
    B.add(Exec);
    B.add(Finish);
    B.add(Sced);
  }


  public void Check()
  {
    if (this.Sced.alpha<=70&&Sced.Pressable==true)
      this.Sced.Lerp_Color=true;
  }

  public void Show()
  {
    this.Check();
    image(Task_T, width/2, Task_T.height/2);
    textSize(17);
    fill(255); 
    text(Name, width/2-(Name.length())*10/2, height/55);
    textSize(13);
    text("Due To :  "+Date[0]+" / "+Date[1]+" / "+Date[2], width/2-(Date.length*3)*13/2, height/30);
    for (int i =0; i<Vis.length; i++)
      if (Vis[i]==0)
        B.get(i).Lerp_Color=false;
      else
        B.get(i).Lerp_Color=true;

    Show_Btn(B);
    if (Vis[0]==1)
      Show_Btn(B1);
    else
      if (Vis[1]==1)
        Show_Btn(B2);
      else
        if (Vis[2]==1)
          Show_Btn(B3);
        else
          if (Vis[3]==1)
            Show_Btn(B4);

    Show_Tasks();
    Progress.Show();
  }


}
