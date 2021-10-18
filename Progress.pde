class Progress
{
  public float x ;
  public float y;
  public float d;
  public float Fx;
  public float Fy;
  public float[] progress;
  public float [] F;
  public boolean Visable=false;
  public boolean Lerp_Progress=false;
  public float lerpSpeed=0.06;
  public float Fd;


  public Progress(float X, float Y, float D)
  {

    this.x = X;
    this.y = Y;
    this.Fd =D;
    progress = new float[4];
    F= new float[4];
  }

  public void Show()
  {
    this.Update();

    if (this.Visable==false)
      return;
    ellipseMode(CENTER);
    fill(#d91e41, 50);
    ellipse(x, y, d, d);//yellow1
    fill(#ff2e5e, 50);
    ellipse(x, y, d-30, d-30);//green1
    fill(#4396dc, 50);
    ellipse(x, y, d-60, d-60);//blue1 
    fill(14, 18, 30,50);
    ellipse(x, y, d-90, d-90);


    showArcs();

    float Tot_P =0;
    for (int i =0; i<F.length; i++)
    {
      float Dev = cur.Arr.get(i).size();
      if (Dev==0)
        Dev=1;
      Tot_P+=(F[i]/Dev)*100;
    }

    Tot_P=Tot_P/F.length; 

    fill(255);  
    text("Total Progress: " +Tot_P
      +"% :  ", 18, 18);
  }

  //---------------------------------------------------------------

  void showArcs() {

    fill(#d91e41);   // 
    arc(x, y, d, d, PI+HALF_PI, map(progress[0], 0, cur.Arr.get(0).size(), PI+HALF_PI, 3.5*PI));//

    fill(#ff2e5e);
    arc(x, y, d-30, d-30, PI+HALF_PI, map(progress[1], 0, cur.Arr.get(1).size(), PI+HALF_PI, 3.5*PI));//

    fill(#4396dc);
    arc(x, y, d-60, d-60, PI+HALF_PI, map(progress[2], 0, cur.Arr.get(2).size(), PI+HALF_PI, 3.5*PI));//

    fill(14, 18, 30);
    arc(x, y, d-90, d-90,  PI+HALF_PI,3.5*PI);//center
  }


  public void Update()
  {

    if (Lerp_Progress==true)
    {
      //this.x=Lerp(x, Fx, lerpSpeed);
      //this.y=Lerp(y, Fy, lerpSpeed);
      this.d=Lerp(d, Fd, lerpSpeed);
      for (int i =0; i<F.length; i++)
        progress[i]=Lerp(progress[i], F[i], lerpSpeed);
    } else
    {
      //  this.x=Lerp(x, 0, lerpSpeed);
      //this.y=Lerp(y, 0, lerpSpeed);
      this.d=Lerp(d, 0, lerpSpeed);
      for (int i =0; i<F.length; i++)
        progress[i]=Lerp(progress[i], F[i], lerpSpeed);
    }

    // this.x=Lerp(x, Fx, lerpSpeed);
    //this.y=Lerp(y, Fy, lerpSpeed);
  }


  public float Lerp(float  Min, float Max, float speed)
  {

    float var = lerp(Min, Max, speed);
    return var;
  }
}
