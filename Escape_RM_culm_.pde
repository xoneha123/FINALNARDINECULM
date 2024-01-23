int currentDoor = 1;  // Current door the player is interacting with
int screen=0;
int fadeDuration = 60;
int fadeTimer = 0;
int fadeTimer2 =0;
int fadeDuration2=70;
boolean[] doorStatus = {true, false, false};  // Status of each door (true for open, false for closed)
String[] doorKeys = {"", "Key1", "Key2", "Key3"};  // Keys required to open each door
boolean hasKey1 = true;
boolean hasKey2 = false;
boolean hasKey3 = false;
String Keynumber = "";
PImage bg, bg1, bg2;
PImage door1case;
PImage escaped;
PImage door3case;
PImage Inventorybag;
PImage Jumpscare;
PImage liam;
String answer=""; //the user writes their name
String name=answer; //the user writes their name
boolean noname=false;
boolean enterPressed=false;
int text1=0, text2=0, text3=0, text4=0, text5=0, text6=0, text7=0, text8=0, text9=0;
//text8 is for when the user beats the game behind door #3
//text7 is before the user starts the game in door #3
//text6 is for the game over screen for game 2 behind door 2
//text5 is for the game over screen for game 1 behind door 1
//text4 is for if the user wins the game in door 2
//text3 is only if the user wins the game in door #1
//text2 is the text before the user starts the game in door #1
//text1 is the text during the introduction and explaining the rules of the escape room
boolean inventory = false; //when it is true the user is able to see what is in their inventory
int numclicks = 10, numclicks2=16; //this is for the game in door #1 and they have limited amount of clicks
int objects=0, objects2=0; //they have to find 6 objects in total in the game in door #1
boolean Butterflyclick =false, Pineconeclick=false, Guitarclick=false; //this is to check whether the object was clicked or not
boolean Bottleclick=false, Handbagclick=false, Tromboneclick=false; //false = the object was not clicked
//true = the object was clicked and it prevents the suer from pressing the same object twice
boolean Anchorclick=false, glassesclick=false, violinclick=false;
boolean hourglassclick=false, piclocketclick=false, lightbulbclick=false;
boolean teddysclick=false, toyhouseclick=false;

float shipX, shipY; //The user's spaceship position
float shipSpeed, shipAcceleration;  //The users spaceship speed
boolean wkey, skey, akey, dkey, spacekey; //boolean variables to store key variables
float shipHeading; //player's spaceship heading in radians
ArrayList<Bullet> bullets; //an array list to store bullets
ArrayList<Asteroid> asteroids; //an array list to store the asteroids
boolean canShoot = true;
boolean gameOver = false;
int shootingCooldown = 10;
int score=0; //this is the score for game #2 //the score for how many asteroids you've hit


void setup() {
  size(900, 800);
  background(0);
  bg=loadImage("can you escape.jpeg");
  bg1=loadImage("escape wallpaper.jpg");
  bg2 = loadImage("mystery background.jpg");
  door1case = loadImage("mystery case.png");
  door3case = loadImage("mystery case2.jpeg");
  Inventorybag = loadImage("Inventory bag.png");
  Jumpscare = loadImage("Jumpscare.jpeg");
  escaped = loadImage("you escaped.jpeg");
  liam = loadImage("liam.png");

  bullets = new ArrayList<>();
  asteroids = new ArrayList<>();
  shipX = 300;
  shipY = 300;
  shipSpeed=0;
  shipAcceleration = 0.1;
  shipHeading = PI/2; //Start facing upward
}


void draw() {

  if (screen==0) {//intro can you escape
    println(screen=0);
    background(0);
    if (fadeTimer < fadeDuration) { //this allows the image to fade in and out for a certain amount of time
      // Fade in
      float alpha = map(fadeTimer, 0, fadeDuration, 0, 255);
      tint(255, alpha);
      image(bg, 0, 0, 900, 800);
    } else if (fadeTimer < 2 * fadeDuration) {
      // Hold the image at full opacity
      image(bg, 0, 0, 900, 800);
    }

    // Increment the timer
    fadeTimer++;
    println(fadeTimer);

    // after the fading you automatically moves onto the next screen
    if (fadeTimer >= 3 * fadeDuration) {
      screen=1;
    }
  }

  if (inventory==true &&(screen!=0 || screen!=3)) { //you can see the inventory as long as you are not on screen 0 or 3
    invent();
  }

  if (screen==1) {//introducing liam and the controls
    println(screen=1);
    background(0);
    if (fadeTimer2 < fadeDuration2) {
      // Fade in
      float alpha = map(fadeTimer2, 0, fadeDuration2, 0, 255);
      tint(255, alpha);
      image(bg1, 0, 0, 900, 800);
    } else if ((fadeTimer2 <= 2 * fadeDuration2) || (fadeTimer2>=2*fadeDuration2)) {
      // Hold the image at full opacity
      image(bg1, 0, 0, 900, 800);
    }

    fadeTimer2++;

    txtbox(50, 570, 770, 200); //I called the function that I created txtbox over here
    fill(255);
    textSize(20);
    if (noname==false) { //this is to make sure that you enter a name before you can move onto the story
      text("Hello! My name is Liam Payne. \n I'm apart of the awesome band One Direction! :) \n I am here to help you escape this place. But first how about you introduce yourself?", 65, 605);
    }

    //if you gave your name you will be able to continue with the story
    if (noname==true) {
      if (text1==0)text("Nice to meet you " + name + "\n Now let me tell you how to play this game", 65, 605);
      if (text1==1) text("Press the bag icon or the letter 'i' to check your inventory, that's where everything that \nyou pick up goes to. In the next room you will find 3 doors the last 2 are closed and the \nfirst door is open. You have to find the keys to each door.", 65, 605);
      if (text1==2)text("Watch out though monsters lurk in each room, they're called grievers \n If you get stung by one... well... you die. \n Well that's all you need to know for now! Good luck! \n I'll always be here with you and i'll give you some tips along the way! :)", 65, 605);
      if (text1==3) screen=2;
    }

    image(Inventorybag, 818, 10, 60, 60);
    println("Inventory bag");

    if (inventory==true) {
      invent();
    }
  }

  if (screen==2) {//beginning the game
    println(screen=2);
    background(0);
    image(bg2, 0, 0, 900, 800);

    door3(670, 200);
    door2(395, 200);
    door1(100, 200);

    displayGameStatus();
    image(Inventorybag, 818, 10, 60, 60);
    println("Inventory bag");

    if (inventory==true) {
      invent();
    }
  }


  if (screen==3) { //The user introduces themselves
    background(0);
    textSize(50);
    fill(255);
    text("ENTER NAME: " + answer, 78, 645);
  }


  if (screen==4) {//the user has entered door #1
    background(0);
    image(door1case, 0, 0, 900, 800);
    if (text2<=1) {
      noStroke();
      txtbox(50, 570, 770, 200);
      textSize(20);
      fill(255);
      if (text2==0) text("Liam: \nWelcome to the first mystery in this escape room on the side there is a list of objects" + name + "\n in this room that you must find. If you are able to find all the objects you wil receive the \n key for door #2. And watch out there's a time limit. If the time runs out well... \n I don't think you want to find out", 65, 605);
      if (text2==1) text("You also have limited amount of clicks depending on how many objects there is. \n In this case you only have 6 clicks, but because I'm an awesome person I will give you an \n extra 3 clicks. You now have 9 clicks in total. If they run out and you didn't find all \n the objects well to put it simply you'll die a very gruesome death. \n Good luck :)", 65, 605);
    }

    if (objects==6 && numclicks>=0) {
      noStroke();
      txtbox(50, 570, 770, 200);
      textSize(20);
      fill(255);
      if (text3==0) text("Liam: \nGood job" + name + "\n You were able to beat this game and receive the key for door 2. \n You can find the key in your inventory", 65, 605);
      if (text3==1) screen=2;
    }

    image(Inventorybag, 818, 10, 60, 60);
    println("Inventory bag");

    if (inventory==true) {
      invent();
    }

    drawButton(15, 15, 100, 50, "HOME");
    noStroke();
    fill(140, 209, 208);
    textSize(20);
    text("Guitar", 794, 365);
    text("Butterfly", 785, 390);
    textSize(15);
    text("Number of Clicks:" + numclicks, 760, 474);

    if (numclicks<=0 && objects<6) {
      println("used up all their clicks and failed to find all the objects");
      screen=7;
    }

    strokeWeight(5);
    stroke(5);
    if (Butterflyclick ==true)line(779, 386, 865, 386);
    if (Pineconeclick==true) line(775, 300, 865, 300);
    if (Guitarclick==true) line(787, 360, 853, 360);
    if (Bottleclick==true)line(787, 333, 853, 333);
    if (Handbagclick==true)line(780, 270, 861, 270);
    if (Tromboneclick==true)line(778, 239, 863, 239);
  }

  if (screen==9) { //explaining the rules for the game behind door 2
    noStroke();
    txtbox(50, 570, 770, 200);
    textSize(20);
    fill(255);
    if (text9==0) text("Liam: \nWelcome to the second game in this escape room this is a missile game. \nUse the WASD keys to control your ship. Use the A and D keys to steer the ship \n left and right. Then use the W key to accelerate and speed up the ship.", 65, 605);
    if (text9==1) text("Press the space bar to shoot the asteroids, but if you get hit \n by an asteroid you lose the game \n Try to shoot 25 asteroids to win the game.", 65, 605);
    if(text9==2) screen=5;
}

  if (screen==5) {//the user enters door #2
    background(0);
    image(Inventorybag, 818, 10, 60, 60);
    println("Inventory bag");
    drawButton(15, 15, 100, 50, "HOME");
    fill(255);
    text("Score: " + score, 128, 50);

    if (inventory==true) {
      invent();
    }

    if (!gameOver) {//check if the user lost the game or not

      //update player's spaceship position
      handleShip();
      updateSpaceship();

      //update and draw bullets
      updateBullets();
      drawBullets();

      //update and draw the asteroids
      updateAsteroids();
      drawAsteroids();

      //Draw players spaceship
      drawSpaceship();
    } else {
      //game over
      fill(255, 0, 0);
      textSize(32);
      text("GAME OVER! :( Press 'R' to restart", 235, 400);
      txtbox(50, 570, 770, 200);
      textSize(20);
      fill(255);
      if (text6==0) text("Liam: \nYou have lost the game " + name + "\n and you were killed by the monster \n Luckily in this room you will respawn each time you die. \nTry to do better next time....", 65, 605);
      if (text6==1) screen=2;
    }

    if (score>=25) {
      hasKey3=true;
      println("user now has key 3");
      fill(0, 255, 0);
      text("YOU WON! :)", 395, 400);
      noStroke();
      txtbox(50, 570, 770, 200);
      fill(255);
      textSize(20);
      if (text4==0) text("Liam: \nGood job!" + name + "\n You were able to win this game and you now have the key for door 3 \n You can find the key in your inventory", 65, 605);
      if (text4==1) screen=2;
      bullets.clear();
      asteroids.clear();
    }

    if (inventory==true) {
    }
  }

if (screen==6) { //the user enters door #3
  background(0);
  image(door3case, 0, 0, 900, 800);
  image(Inventorybag, 818, 10, 60, 60);

  if (inventory==true) {
    invent();
  }

  noStroke();
  drawButton(15, 15, 100, 50, "HOME");
  fill(27, 32, 36);
  rect(742, 664, 158, 136);
  fill(117, 148, 143);
  textSize(20);
  text("Number of \nClicks: " + numclicks2, 753, 720);

  if (text7<=1) {
    noStroke();
    txtbox(50, 570, 770, 200);
    textSize(20);
    fill(255);
    if (text7==0) text("Liam: \nWelcome to the final mystery in this escape room this will be a similar mystery as \nthe first mystery " + name + ". If you are able to find all the objects you will finally be able to escape.", 65, 605);
    if (text7==1) text("You also have limited amount of clicks depending on how many objects there is. \n In this case you only have 15 clicks in total. \nIf they run out and you didn't find all the objects well to put it simply you'll die a very \ngruesome death. Good luck :)", 65, 605);
  }

  if (objects2>=8 && numclicks2>=0) {
    noStroke();
    txtbox(50, 570, 770, 200);
    textSize(20);
    fill(255);
    if (text7==2) text("Liam: \nGood job" + name + "\n You were able to beat this game and you can finally escape!", 65, 605);
    if (text7>=3) screen=8;
    println(text7);
  }

  if (numclicks2<=0 && objects2<8) {
    println("used up all their clicks and failed to find all the objects");
    screen=7;
  }

  strokeWeight(5);
  stroke(5);
  if (Anchorclick ==true)line(777, 236, 860, 236);
  if (glassesclick==true) line(770, 277, 870, 277);
  if (violinclick==true) line(795, 317, 850, 317);
  if (hourglassclick==true)line(775, 350, 865, 350);
  if (piclocketclick==true)line(765, 380, 880, 380);
  if (lightbulbclick==true)line(780, 413, 865, 413);
  if (teddysclick==true)line(770, 452, 872, 452);
  if (toyhouseclick==true)line(775, 495, 870, 495);
}

if (screen==7) { //game over screen
  background(0);
  image(Jumpscare, 0, 0, 900, 800);
  txtbox(50, 570, 770, 200);
  textSize(20);
  fill(255);
  if (text5==0) text("Liam: \nUnfortunately you have lost the game " + name + "\n and you have been killed by the monster that resides in this room \n luckily I have revived you. Try not to die again :) ", 65, 605);
  if (text5==1) {
    screen=2;
    numclicks=11;
    objects=0;
    Butterflyclick =false;
    Pineconeclick= false;
    Guitarclick= false;
    Bottleclick=false;
    Handbagclick=false;
    Tromboneclick=false;

    numclicks2=16;
    objects2=0;
    Anchorclick =false;
    glassesclick= false;
    violinclick= false;
    hourglassclick=false;
    piclocketclick=false;
    lightbulbclick=false;
    teddysclick=false;
    toyhouseclick=false;
  }
}

if (screen==8) {//the user won and escaped the room
  background(0);
  image(escaped, 0, 0, 900, 800);
  fill(255, 0, 0);
  textSize(50);
  text("CONGRATS! YOU ESCAPED :)", 180, 400);
}

textSize(20);
fill(255, 2435, 320);
text(mouseX + "," +mouseY, 500, 50);
}


void mousePressed() {

  if (screen==7) {
    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750)text5++;
  }
  
  if(screen==9){
    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750)text9++;
  }

  if (screen==1) {
    if (noname==false) {
      if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750) {
        screen=3;
        println(screen=3);
      } //this is if the user still didn't input their name
    }

    if (mousePressed==true && mouseX>818 && mouseX<878 && mouseY> 10 && mouseY<70) inventory=true; //this is for the inventory bag

    if (noname==true) { //this only occurs once the user inputs their name
      if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750)text1++; //this is to read the next text message
    }
  }

  if (screen==2) {
    if (mousePressed==true && mouseX>100 && mouseX<300 && mouseY>200 && mouseY<600) {
      interactWithDoor();
    }

    if (mousePressed==true && mouseX>818 && mouseX<878 && mouseY> 10 && mouseY<70) inventory=true;

    if (mousePressed==true && mouseX>100 && mouseX<300 && mouseY>200 && mouseY<600 && hasKey1==true) {
      println("user has door key #1");
      screen=4;
      currentDoor=2;
    } //if they have door key #1 which they do they will be able to enter door 1

    if (mousePressed==true && mouseX>395 && mouseX<595 && mouseY>200 && mouseY<600 && hasKey2==true) {
      println("user has door key #2");
      screen=9;
    } else {
      println("user doesn't have door key #2");
      text("Door 2 is closed, you must find door key #2", 30, 55); //fix this part
    } //this is to see if they have the door key for door #2


    if (mousePressed==true && mouseX>670 && mouseX<870 && mouseY>205 && mouseY<605 && hasKey3==true) {
      println("user has door key #3");
      screen=6;
    } else {
      println("user doesn't have door key #3");
      text("Door 3 is closed, you must find door key #3", 30, 55); //fix this part
    } //this is to see if they have the door key for door #3
  }

  if (inventory==true && mousePressed==true && mouseX>795 && mouseX<833 && mouseY>62 && mouseY<100) {
    inventory=false;
  } //this is to close the inventory tab

  if (screen==4) {

    if (mousePressed==true && mouseX>818 && mouseX<878 && mouseY> 10 && mouseY<70) inventory=true; //this is for the inventory bag

    if (mousePressed==true && mouseX> 15 && mouseX<115 && mouseY>15 && mouseY<65) {
      screen=2;
      numclicks=11;
      objects=0;
      Butterflyclick =false;
      Pineconeclick= false;
      Guitarclick= false;
      Bottleclick=false;
      Handbagclick=false;
      Tromboneclick=false;
    } //this is the home button


    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750) {
      text2++;
      println(text2);
    }


    if (mousePressed==true && text2==2 && mouseX>0 && mouseX<900 && mouseY>0 && mouseY<800 && !ExcludedAreas(mouseX, mouseY)) numclicks=numclicks-1;

    if (mousePressed==true && Butterflyclick==false && mouseX>136 && mouseX<183 && mouseY>511 && mouseY<556) {
      println("Butterfly has been found");
      numclicks = numclicks-1;
      objects = objects+1;
      println("Objects found:" + objects);
      Butterflyclick=true;
    }
    if (mousePressed==true && Pineconeclick==false && mouseX>315 && mouseX<355 && mouseY>350 && mouseY<388) {
      println("Pinecones has been found");
      numclicks = numclicks-1;
      objects = objects+1;
      println("Objects found:" + objects);
      Pineconeclick=true;
    }

    if (mousePressed==true && Guitarclick==false && mouseX>561 && mouseX<741 && mouseY>20 && mouseY<42) {
      println("Guitar has been found");
      numclicks = numclicks-1;
      objects = objects+1;
      println("Objects found:" + objects);
      Guitarclick=true;
    }

    if (mousePressed==true && Bottleclick==false && mouseX>525 && mouseX<637 && mouseY>592 && mouseY<703) {
      println("Bottle has been found");
      numclicks = numclicks-1;
      objects = objects+1;
      println("Objects found:" + objects);
      Bottleclick=true;
    }

    if (mousePressed==true && Handbagclick==false && mouseX>472 && mouseX<537 && mouseY>704 && mouseY<770) {
      println("Handbag has been found");
      numclicks = numclicks-1;
      objects = objects+1;
      println("Objects found:" + objects);
      Handbagclick=true;
    }

    if (mousePressed==true && Tromboneclick==false && mouseX>417 && mouseX<446 && mouseY>350 && mouseY<463) {
      println("Trombone has been found");
      numclicks = numclicks-1;
      objects = objects+1;
      println("Objects found:" + objects);
      Tromboneclick=true;
    }

    if (mousePressed==true && objects==6 && numclicks>=0) {
      text3=0;
      hasKey2=true;
    }
    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750)text3++;
  }

  if (screen==5) {
    if (mousePressed==true && mouseX> 15 && mouseX<115 && mouseY>15 && mouseY<65) {
      screen=2;
    }

    if (mousePressed==true && mouseX>818 && mouseX<878 && mouseY> 10 && mouseY<70) inventory=true;

    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750) {
      text4++;

      println("user has key 3 now");
    }
  }

  if (screen==6) {
    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750)text7++;

    if (mousePressed==true && mouseX>818 && mouseX<878 && mouseY> 10 && mouseY<70) inventory=true; //this is for the inventory bag

    if (mousePressed==true && mouseX> 15 && mouseX<115 && mouseY>15 && mouseY<65) {
      screen=2;
      numclicks2=16;
      objects2=0;
      Anchorclick =false;
      glassesclick= false;
      violinclick= false;
      hourglassclick=false;
      piclocketclick=false;
      lightbulbclick=false;
      teddysclick=false;
      toyhouseclick=false;
    } //this is the home button


    if (mousePressed==true && objects2==8 && numclicks2>=0) {
      text7=2;
      text7++;
      println(text7);
    }

    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750 && objects2==8 && numclicks2>=0)text7++;

    if (mousePressed==true && text7==2 && mouseX>0 && mouseX<900 && mouseY>0 && mouseY<800 && !ExcludedAreas2(mouseX, mouseY)) numclicks2=numclicks2-1;

    if (mousePressed==true && mouseX>700 && mouseX<800 && mouseY>700 && mouseY<750)text8++;

    if (mousePressed==true && Anchorclick==false && mouseX>0 && mouseX<35 && mouseY>695 && mouseY<730) {
      println("Anchor has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      Anchorclick=true;
    }

    if (mousePressed==true && glassesclick==false && mouseX>565 && mouseX<630 && mouseY>580 && mouseY<645) {
      println("the 2 glasses has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      glassesclick=true;
    }

    if (mousePressed==true && violinclick==false && mouseX>495 && mouseX<532 && mouseY>520 && mouseY<710) {
      println("violin has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      violinclick=true;
    }

    if (mousePressed==true && hourglassclick==false && mouseX>450 && mouseX<480 && mouseY>335 && mouseY<405) {
      println("hourglass has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      hourglassclick=true;
    }

    if (mousePressed==true && piclocketclick==false && mouseX>475 && mouseX<510 && mouseY>380 && mouseY<425) {
      println("the picture locket has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      piclocketclick=true;
    }

    if (mousePressed==true && lightbulbclick==false && mouseX>400 && mouseX<440 && mouseY>140 && mouseY<170) {
      println("lightbulb has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      lightbulbclick=true;
    }

    if (mousePressed==true && teddysclick==false && (mouseX>143 && mouseX<190 && mouseY>510 && mouseY<555) || (mouseX>670 && mouseX<715 && mouseY>0 && mouseY<48) || (mouseX>655 && mouseX<692 && mouseY>365 && mouseY<430)) {
      println("3 teddys has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      teddysclick=true;
    }

    if (mousePressed==true && toyhouseclick==false && mouseX>600 && mouseX<680 && mouseY>100 && mouseY<165) {
      println("lightbulb has been found");
      numclicks2 = numclicks2-1;
      objects2 = objects2+1;
      println("Objects found:" + objects2);
      toyhouseclick=true;
    }
  }
}

boolean ExcludedAreas(float x, float y) {
  return((mouseX>417 && mouseX<446 && mouseY>350 && mouseY<463) || (mouseX>472 && mouseX<537 && mouseY>704 && mouseY<770) || (mouseX>525 && mouseX<637 && mouseY>592 && mouseY<703) || (mouseX>561 && mouseX<741 && mouseY>20 && mouseY<42) || (mouseX>315 && mouseX<355 && mouseY>350 && mouseY<388) || (mouseX>136 && mouseX<183 && mouseY>511 && mouseY<556));
}

boolean ExcludedAreas2(float x, float y) {
  return((mouseX>600 && mouseX<680 && mouseY>100 && mouseY<165) || (mouseX>143 && mouseX<190 && mouseY>510 && mouseY<555) || (mouseX>670 && mouseX<715 && mouseY>0 && mouseY<48) || (mouseX>655 && mouseX<692 && mouseY>365 && mouseY<430) || (mouseX>400 && mouseX<440 && mouseY>140 && mouseY<170) || (mouseX>475 && mouseX<510 && mouseY>380 && mouseY<425) || (mouseX>450 && mouseX<480 && mouseY>335 && mouseY<405) || (mouseX>495 && mouseX<532 && mouseY>520 && mouseY<710) || (mouseX>565 && mouseX<630 && mouseY>580 && mouseY<645) || (mouseX>0 && mouseX<35 && mouseY>695 && mouseY<730));
}



void updateSpaceship() {
  //update the spaceship's position and rotation based on its speed and heading
  shipX += cos(shipHeading) * shipSpeed;
  shipY += sin(shipHeading) * shipSpeed;
  shipSpeed *=0.99; //apply some friction to slow down the spaceship

  //keep the shape within the bounds of the screen
  shipX = constrain(shipX, 0, 900);
  shipY = constrain(shipY, 0, 800);

  //check for collisions with asteroids
  for (Asteroid asteroid : asteroids) {
    float d = dist(shipX, shipY, asteroid.x, asteroid.y);
    if (d<20) {
      gameOver = true;
      return;
    }
  }
}

void drawSpaceship() {

  //drawing a rotated spaceship at the current position
  pushMatrix();
  translate(shipX, shipY);
  rotate(shipHeading);
  fill(255);
  triangle(5, 0, -20, -10, -20, 10);
  circle(5, 0, 3);
  popMatrix();
}

void shoot() {
  //create a new bullet at the spaceship's position
  Bullet bullet = new Bullet(shipX, shipY, shipHeading);
  bullets.add(bullet);
}

void updateBullets() {
  //update the position of each bullet
  for (int i = bullets.size()-1; i>=0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.update();

    //remove bullets that have gone off-screen
    if (bullet.isOffScreen()) {
      bullets.remove(i);
    }

    //check if the bullet hit the asteroid
    for (int j = asteroids.size()-1; j >= 0; j--) {
      Asteroid asteroid = asteroids.get(j);
      if (bullet.hits(asteroid)) {
        bullets.remove(i);
        asteroids.remove(j);
        score++;
        println(score);
      }
    }
  }

  //cooldown for shooting the bullets
  if (!canShoot) {
    shootingCooldown--;
    println(shootingCooldown);
    if (shootingCooldown<=0) {
      canShoot = true;
      shootingCooldown = 10; //reset cooldown for the next timr it occurs
    }
  }
}

void resetGame() {
  //reset the game variables
  shipX = 300;
  shipY = 300;
  shipSpeed = 0;
  shipAcceleration = 0.1;
  shipHeading = PI/2;
  gameOver = false;
  bullets.clear();
  asteroids.clear();
  score=0;
}

void updateAsteroids() {
  //update the position of each asteroid
  for (int i=asteroids.size()-1; i>=0; i--) {
    Asteroid asteroid=asteroids.get(i);
    asteroid.update();

    //remove the asteroids that have gone off-screen
    if (asteroid.isOffScreen()) {
      asteroids.remove(i);
    }
  }

  //add a new asteroid randomly anywhere on the screen
  if (frameCount%40==0) {
    asteroids.add(new Asteroid());
  }
}

void handleShip() {
  if (wkey==true) shipSpeed += shipAcceleration; //this is to speed up the ship
  if (akey==true) shipHeading -= 0.05; //rotate left
  if (dkey==true) shipHeading += 0.05; //rotate right

  //check space key for shooting
  if (spacekey==true && canShoot) {
    shoot();
    canShoot = false;
  }
}

void drawAsteroids() {
  //draw each asteroid
  for (Asteroid asteroid : asteroids) {
    asteroid.draw();
  }
}

void drawBullets() {
  //Draw each bullet
  for (Bullet bullet : bullets) {
    bullet.draw();
  }
}

class Bullet {
  float x, y; //Bullet position
  float speed; //bullet speed
  float heading; //bullet heading

  Bullet(float x, float y, float heading) {
    this.x=x;
    this.y=y;
    this.speed=5;
    this.heading = heading;
  }

  void update() {
    //move the bullet upwards
    //y-=speed;

    //move the bullet in the direction it was shot
    x += cos(heading) * speed;
    y += sin(heading) * speed;
  }

  void draw() {
    //drawing the bullet
    fill(255, 0, 0);
    ellipse(x, y, 10, 10);
  }

  boolean isOffScreen() {
    //check if the bullet is off-screen
    //return y<0;
    return x<0 || x> 900 || y<0 || y>800;
  }

  boolean hits(Asteroid asteroid) {
    //check if the bullet collides with the asteroid using a boolean so if it hits it's true if it doesn't hit it's false
    float d = dist(x, y, asteroid.x, asteroid.y);
    return d < 15;
  }
}

class Asteroid {
  float x, y; //asteroid position on the screen
  float speed; //speed of the asteroid
  float heading; //where the asteroid is heading towards to

  Asteroid() {
    //randomly place the asteroid anywhere on the screen
    if (random(1)>0.5) { //checks if the random number between 0 and 1 is greater than 0.5
      x=random(900);
      y=random(1)>0.5 ? 0 : 800; //if the condition is true it evaluates to the value before the colon which would be 0 if the condition is false it evalutes to the value after the colon which would be 800
      //so this whole expression can be read as if a random number between 0 and 1 is greater than 0.5 you would set y to 0 otherwise it would be 800
    } else {
      x = random(1) >0.5 ? 0 : 900;
      y= random(800);
    }

    speed = 2;
    heading = atan2(800/2 - y, 900/2-x); //makes the asteroid point towards the center of the window
  }

  void update() {
    //move the asteroid in the direction it is heading
    x += cos(heading) * speed;
    y += sin(heading) * speed;
  }

  void draw() {
    //drawing the asteroid
    fill(150);
    ellipse(x, y, 30, 30);
  }

  boolean isOffScreen() {
    //check if the asteroid is off-screen
    return (x<0 || x> 900 || y<0 || y>800);
  }
}

void interactWithDoor() {
  if (doorStatus[currentDoor - 1]) {
    if (currentDoor < 4) {
      currentDoor++;
    } else {
      println("Congratulations! You've escaped!");
      exit();
    }
  } else {
    if (checkForKey()) {
      doorStatus[currentDoor - 1] = true;
    } else {
      println("You need to find the key to open the door!");
    }
  }
}

boolean checkForKey() {
  // Simulate finding the key (you can replace this with your own logic)
  if (currentDoor > 1 && currentDoor <= 4) {
    println("You found " + doorKeys[currentDoor] + "!");
    return true;
  } else {
    return false;
  }
}

void displayGameStatus() {
  fill(255);
  textSize(20);
  text("Current Door: " + currentDoor, 30, 25);

  //if (currentDoor==1 || (currentDoor==2 && hasKey2) || (currentDoor==3) {
  //  text("Door " +currentDoor + " is open!", 30,55);
  //} else {
  //  text("Door is closed. Find " + doorKeys[currentDoor] + " to open.", 30, 55);
  //}
}

void door1(float x, float y) {
  // Futuristic door frame
  fill(0, 100, 200);
  rect(x, y, 200, 400);

  // Door panels
  fill(50, 150, 255);
  rect(110, 220, 180, 360);

  // Lights on the door
  drawLights(150, 250);
  drawLights(200, 250);
  drawLights(250, 250);

  // Doorknob
  fill(200, 200, 0);
  ellipse(280, 400, 20, 20);
}

void door2(float x, float y) {
  // Magical door frame
  fill(148, 0, 211);  // Purple color
  rect(x, y, 200, 400);

  // Mystical symbols on the door
  drawSymbol(445, 250, 30, color(255, 255, 0));  // Yellow symbol
  drawSymbol(495, 250, 25, color(0, 255, 255));  // Cyan symbol
  drawSymbol(545, 250, 20, color(255, 0, 0));    // Red symbol

  // Doorknob
  fill(200, 200, 0);
  ellipse(570, 400, 20, 20);
}


void door3(float x, float y) {
  // Cyberpunk door frame
  //fill(100,0,100);
  fill(153, 86, 98);
  rect(x, y, 200, 400);

  // Cyberpunk door texture
  drawCyberpunkTexture(695, 220, 160, 360);

  // Neon lights on the door
  drawNeonLight(720, 250, color(0, 255, 0));  // Green
  drawNeonLight(770, 250, color(0, 0, 255));  // Blue
  drawNeonLight(820, 250, color(255, 0, 0));  // Red

  // Doorknob
  fill(200, 200, 0);
  ellipse(840, 400, 20, 20);
}

void drawLights(float x, float y) {
  fill(255, 255, 0);
  ellipse(x, y, 10, 10);
}

void drawLight(float x, float y) {
  fill(255, 0, 0);
  ellipse(x, y, 20, 20);
}

void drawCyberpunkTexture(float x, float y, float w, float h) {
  fill(80, 80, 80);
  noStroke();
  for (float i = x; i < x + w; i += 5) {
    for (float j = y; j < y + h; j += 5) {
      ellipse(i, j, 3, 3);
    }
  }
}

void drawNeonLight(float x, float y, color lightColor) {
  fill(lightColor);
  noStroke();
  ellipse(x, y, 15, 15);
}

void drawSymbol(float x, float y, float size, color symbolColor) {
  fill(symbolColor);
  noStroke();
  ellipse(x, y, size, size);
}

void drawPanel(float x, float y, float w, float h, color panelColor) {
  fill(panelColor);
  rect(x, y, w, h);
}

void drawButton(int x, int y, int w, int h, String title) {
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    fill(0, 255, 0);
  } else fill(255, 0, 0);
  rect(x, y, w, h);
  textSize(30);
  fill(0);
  text(title, x + w/2 - textWidth(title)/2, y + h - 10);
}

void txtbox(int x, int y, int w, int h) {
  fill(255);
  rect(x, y, w, h);
  fill(0);
  rect(x+10, y+10, w-20, h-20);
  image(liam, 650, 420, 150, 150);
  drawButton(700, 700, 100, 50, "NEXT");
}

void invent() {
  fill(100, 220);
  rect(50, 50, 800, 600);
  fill(255);
  noStroke();
  circle(814, 80, 40);
  textSize(33);
  fill(0);
  text("X", 805, 88);

  if (hasKey2==true) {
    text("You have door key #2", 200, 200);
  }
}

void keyPressed() {

  if (screen==5) { //set corresponding key variables to true when pressed
    if (key=='w' || key == 'W')wkey=true;
    if (key=='s' || key=='S')skey=true;
    if (key=='a' || key=='A') akey=true;
    if (key == 'd' || key == 'D') dkey=true;
    if (key==' ')spacekey=true;
    if (key == 'r' || key == 'R')resetGame(); //restart the game
  }

  if (key=='i' && (screen!=3 || screen!=0)) {
    inventory=true;
    println("Inventory is open");
  }

  //keyboard
  if (enterPressed==false && screen==3) {
    if (key=='1') answer=answer+"1";
    if (key=='2') answer=answer+"2";
    if (key=='3') answer=answer+"3";
    if (key=='4') answer=answer+"4";
    if (key=='5') answer=answer+"5";
    if (key=='6') answer=answer+"6";
    if (key=='7') answer=answer+"7";
    if (key=='8') answer=answer+"8";
    if (key=='9') answer=answer+"9";
    if (key=='0') answer=answer+"0";
    if (key=='q') answer=answer+"q";
    if (key=='w') answer=answer+"w";
    if (key=='e') answer=answer+"e";
    if (key=='r') answer=answer+"r";
    if (key=='t') answer=answer+"t";
    if (key=='y') answer=answer+"y";
    if (key=='u') answer=answer+"u";
    if (key=='i') answer=answer+"i";
    if (key=='o') answer=answer+"o";
    if (key=='p') answer=answer+"p";
    if (key=='a') answer=answer+"a";
    if (key=='s') answer=answer+"s";
    if (key=='d') answer=answer+"d";
    if (key=='f') answer=answer+"f";
    if (key=='g') answer=answer+"g";
    if (key=='h') answer=answer+"h";
    if (key=='j') answer=answer+"j";
    if (key=='k') answer=answer+"k";
    if (key=='l') answer=answer+"l";
    if (key=='z') answer=answer+"z";
    if (key=='x') answer=answer+"x";
    if (key=='c') answer=answer+"c";
    if (key=='v') answer=answer+"v";
    if (key=='b') answer=answer+"b";
    if (key=='n') answer=answer+"n";
    if (key=='m') answer=answer+"m";
    if (key==BACKSPACE && answer.length() > 0) answer = answer.substring(0, answer.length()-1);
    if (key==' ') answer=answer+" ";

    if (key==ENTER) {
      enterPressed=true;
      noname=true;
      screen=1;
      name=answer;
      println("enter pressed");
    }
  }
}

void keyReleased() {
  if (screen==5) { // set the corresponding key variables to false when released
    if (key=='w' || key == 'W')wkey=false;
    if (key=='s' || key=='S')skey=false;
    if (key=='a' || key=='A') akey=false;
    if (key == 'd' || key == 'D') dkey=false;
    if (key==' ')spacekey=false;
  }
}
