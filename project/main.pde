import java.util.*;

public PImage img;
public Mnode[][] map;
public ArrayDeque<Mnode> moves;
public ArrayList<PImage> pacmenList;

public Ghost red;
public Ghost yellow;
public Ghost blue;
public Ghost pink;

public int dx;
public int dy;
public int d;
public int f;
public int way;
public int left;
public int animer;
public int score;
public int time;
public int speed;
public int lives;
public int screen;
public int reallyobvious;
public Mnode currentposi;

void setup() {
  frameRate(50);
  screen = 0;
  speed = 3;
  lives = 3;
  score = 0;
  f = 0;
  pacmenList = new ArrayList<PImage>();
  for (int i = 0; i < 49; i++) {
    PImage temp = loadImage(i + ".png");
    pacmenList.add(temp);
  }
  left = 0;
  map= new Mnode[24][24];
  moves = new ArrayDeque<Mnode>();

  size(600, 512);
  img = loadImage("Mapa.jpg");
  background(img);
  for (int x = 0, dx = 40/2; x < 24; x ++, dx += 41/2) {
    for (int y = 0, dy = 50/2; y < 24; y ++, dy += 41/2) {
      map[x][y] = new Mnode(x, y, dx, dy, true);
      left += 1;
    }
  }

  mapping();

  pacReset();
  fill(255, 255, 255);
  map[2][21].has = new PowerUp(map[2][21], 2, 21);
  map[2][2].has = new PowerUp(map[2][2], 2, 2);
  map[21][2].has = new PowerUp(map[21][2], 21, 2);
  map[21][21].has = new PowerUp(map[21][21], 21, 21);
  fill(255, 255, 0);
  ghostReset();
  currentposi = moves.peek();
}

void draw() {
  if (screen == 0) {
    gameplay();
  } else if (screen == 1) {
    setup();
    screen++;
    gameover();
  } else {
    setup();
    screen = 2;
    gamewon();
  }
  time++;
}

void gameplay() {
  //System.out.println(time);
  imageMode(CENTER);

  if (moves.size() > 0 && red.moves.size() > 1 && yellow.moves.size() > 1 && blue.moves.size() > 1 && pink.moves.size() > 1) {
    ArrayList<Mnode> positions = new ArrayList<Mnode>();
    positions.add(red.moves.peek());
    positions.add(yellow.moves.peek());
    positions.add(blue.moves.peek());
    positions.add(pink.moves.peek());
    delay(13);
    switch (contained(positions, moves.peek())) {
    case 0: 
      if (red.edible == false) {
        ghostReset("red");
        score += 500;
      } else {
        lives--;
        pacReset();
        ghostReset();
      }
      break;
    case 1: 
      if (yellow.edible == false) {
        ghostReset("yellow");
        score += 500;
      } else {
        lives--;
        pacReset();
        ghostReset();
      }
      break;
    case 2: 
      if (blue.edible == false) {
        ghostReset("blue");
        score += 500;
      } else {
        lives--;
        pacReset();
        ghostReset();
      }
      break;
    case 3: 
      if (pink.edible == false) {
        ghostReset("pink");
        score += 500;
      } else {
        lives--;
        pacReset();
        ghostReset();
      }
      break;
    default: 
      //System.out.println( "DEBUG");
    }
  }
  /*
  if (time != 0) {
   if (time%200 == 0) {
   map[11][11].walkable = false;
   map[12][11].walkable = false;
   }
   if (time%300 == 0) {
   map[11][10].walkable = false;
   map[12][10].walkable = false;
   }
   }
   */
  if ((int)(Math.random() * 2000) == 42) {
    int sax = (int)(24 * Math.random());
    int say = (int)(24 * Math.random());
    if (map[sax][say].walkable) {
      map[sax][say].has = new PowerUp(map[sax][say], sax, say);
    }
  }

  //cause lag?
  //background(loadImage("Map.jpg"));
  background(img);
  if (animer == 0) {
    animer = 2;
    way = 2;
  } else {
    if (animer == 12) {
      animer = 10;
      way = -2;
    } else {
      animer += way;
    }
  }
  if (animer == 0) {
    image(pacmenList.get(0), moves.peek().x, moves.peek().y, 20, 20);
  } else {
    image(pacmenList.get((12 * f) + animer), moves.peek().x, moves.peek().y, 20, 20);
  }
  fill(255, 255, 255);
  textAlign(CENTER);
  textSize(20);
  text("SCORE", 550, 70);
  text("" + score, 550, 100);
  text("LIVES", 550, 150);
  for (int i = 0, posi = 527; i < lives; i++, posi += 25) {
    image(pacmenList.get(23), posi, 180, pacmenList.get(23).width/2, pacmenList.get(23).height/2);
  }
  text("EXIT", 550, 420);
  //System.out.println(reallyobvious);

  if (reallyobvious != 0) {
    red.edible = false;
    yellow.edible = false;
    blue.edible = false;
    pink.edible = false;
  }

  if (reallyobvious == 0) {
    red.edible = true;
    yellow.edible = true;
    blue.edible = true;
    pink.edible = true;
  }
  red.pacmanPosition = currentposi;
  yellow.pacmanPosition = currentposi;
  blue.pacmanPosition = currentposi;
  pink.pacmanPosition = currentposi;
  int style = 1;
  if ((time/250)%2 == 0) {
    style = 0;
  }
  red.display(style);
  yellow.display(style);
  blue.display(style);
  pink.display(style);

  //System.out.println("END OF WAVE");

  if (moves.size() > 1) {
    moves.removeFirst();
  } else {
    if (d != 0) {
      try {
        if (d == 1) {
          if (map[dx][dy - 1].walkable) {
            moves = Mnode.calculate(moves.peek(), map[dx][dy - 1], speed);
            dy -= 1;
          } else {
            d = 0;
          }
        }
        if (d == 2) {
          if (map[dx + 1][dy].walkable) {
            moves = Mnode.calculate(moves.peek(), map[dx + 1][dy], speed);
            dx += 1;
          } else {
            d = 0;
          }
        }
        if (d == 3) {
          if (map[dx][dy + 1].walkable) {
            moves = Mnode.calculate(moves.peek(), map[dx][dy + 1], speed);
            dy += 1;
          } else {
            d = 0;
          }
        }
        if (d == 4) {
          if (map[dx - 1][dy].walkable) {
            moves = Mnode.calculate(moves.peek(), map[dx - 1][dy], speed);
            dx -= 1;
          } else {
            d = 0;
          }
        }
        //System.out.println(moves.peek());
        currentposi = moves.peek();
      }
      catch (IndexOutOfBoundsException e) {
        d = 0;
      }
    }

    if (!(map[(moves.peek().x - (40/2)) / (41/2)][(moves.peek().y - (50/2)) / (41/2)].stepped)) {
      map[(moves.peek().x - (40/2)) / (41/2)][(moves.peek().y - (50/2)) / (41/2)].stepped = true;
      score += 200;
      left -= 1;
    }

    if (null != map[(moves.peek().x - (40/2)) / (41/2)][(moves.peek().y - (50/2)) / (41/2)].has) {
      reallyobvious = 101;
      map[(moves.peek().x - (40/2)) / (41/2)][(moves.peek().y - (50/2)) / (41/2)].has = null;
    }

    if (reallyobvious > 0) {
      reallyobvious -= 1;
      //System.out.println(reallyobvious);
    }
  }

  for (int x = 0; x < 24; x ++) {
    for (int y = 0; y < 24; y ++) {
      Mnode cur = map[x][y];
      fill(255, 255, 255);
      if (cur.stepped) {
      } else {
        rect(cur.x - 5, cur.y - 5, 10, 10);
      }
      if (null != cur.has) {
        ellipse(cur.x, cur.y, 21, 21);
      }
      fill(255, 255, 0);
    }
  }

  if (left == 0) {
    clear();
    screen = 2;
  }

  if (lives < 0) {
    screen++;
  }
}

void gameover() {
  background(0, 0, 0);
  fill(255, 255, 255);
  textAlign(CENTER);
  textSize(50);
  text("GAME OVER", img.width/2, img.height/3);
  textSize(25);
  text("TOUCH TO CONTINUE", img.width/2, img.height - img.height/3);
}

void gamewon() {
  background(0, 0, 0);
  fill(255, 255, 255);
  textAlign(CENTER);
  textSize(50);
  text("GAME WON", img.width/2, img.height/3);
  textSize(25);
  text("TOUCH TO CONTINUE", img.width/2, img.height - img.height/3);
}

int contained(ArrayList<Mnode> a, Mnode x) {
  for (int i = 0; i < a.size(); i++) {
    if (compare(a.get(i), x) < 50/2) {
      return i;
    }
  }
  return -1;
}

int compare(Mnode first, Mnode other) {
  return first.compareTo(other);
}

void pacReset() {
  moves = new ArrayDeque<Mnode>();
  moves.addLast(map[0][0]);
  moves.addLast(map[0][0]);
  dx = 0;
  dy = 0;
  d = 0;
  animer = 0;
  f = 0;
  way = 1;
}

void ghostReset() {
  red = new Ghost("red");
  red.start(map[10][11]);
  yellow = new Ghost("yellow");
  yellow.start(map[11][11]);
  blue = new Ghost("blue");
  blue.start(map[12][11]);
  pink = new Ghost("pink");
  pink.start(map[13][11]);

  //retrue
  map[11][10].walkable = true;
  map[12][10].walkable = true;
  map[11][11].walkable = true;
  map[12][11].walkable = true;
  ghostReset("red");
  ghostReset("yellow");
  ghostReset("blue");
  ghostReset("pink");
}

void ghostReset(String name) {

  switch (name) {
  case "red": 
    red = new Ghost("red");
    red.start(map[10][11]);
    break;
  case "yellow": 
    yellow = new Ghost("yellow");
    yellow.start(map[11][11]);
    break;
  case "blue": 
    blue = new Ghost("blue");
    blue.start(map[12][11]);
    break;
  case "pink": 
    pink = new Ghost("pink");
    pink.start(map[13][11]);
    break;
  default: 
    //System.out.println( "INVALID. CURRENTLY THERE ARE ONLY:\n * + - / %");
  }

  //retrue
  map[11][10].walkable = true;
  map[12][10].walkable = true;
  map[11][11].walkable = true;
  map[12][11].walkable = true;
  time = 0;
}

void keyPressed() {
  //println(mouseX +"," + mouseY);
  //System.out.println(key);
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      d = 4;
      f = 3;
    }
    if (keyCode == RIGHT) {
      d = 2;
      f = 1;
    }
    if (keyCode == UP) {
      d = 1;
      f = 0;
    }
    if (keyCode == DOWN) {
      d = 3;
      f = 2;
    }
  }
  
  //normal speed
  if(key == 'a'){
    speed = 3;
  }
  //super speed
  if(key == 's'){
    speed = 1000;
  }
  //slow speed
  if(key == 'd'){
    speed = 1;
  }
  //ghosting
  if(key == 'z'){
    reallyobvious = 200;
  }
  //change to non edible
  if(key == 'x'){
    reallyobvious = 0;
  }
}

void mousePressed() {
  if (screen == 1) {
    screen--;
  }
  if (screen == 2) {
    screen -= 2;
  }
  if (screen == 0 && mouseX > 520 && mouseX < 565 && mouseY > 400 && mouseY <445) {
    exit();
  }
}

void mapping() {
  map[1][1].walkable = false;
  map[1][2].walkable = false;
  map[1][3].walkable = false;
  map[1][4].walkable = false;
  map[1][6].walkable = false;
  map[1][7].walkable = false;
  map[1][8].walkable = false;
  map[1][9].walkable = false;
  map[1][10].walkable = false;
  map[1][13].walkable = false;
  map[1][14].walkable = false;
  map[1][15].walkable = false;
  map[1][16].walkable = false;
  map[1][17].walkable = false;
  map[1][19].walkable = false;
  map[1][20].walkable = false;
  map[1][21].walkable = false;
  map[1][22].walkable = false;
  map[2][1].walkable = false;
  map[2][22].walkable = false;
  map[3][1].walkable = false;
  map[3][3].walkable = false;
  map[3][4].walkable = false;
  map[3][5].walkable = false;
  map[3][6].walkable = false;
  map[3][7].walkable = false;
  map[3][8].walkable = false;
  map[3][9].walkable = false;
  map[3][10].walkable = false;
  map[3][13].walkable = false;
  map[3][14].walkable = false;
  map[3][15].walkable = false;
  map[3][16].walkable = false;
  map[3][17].walkable = false;
  map[3][18].walkable = false;
  map[3][19].walkable = false;
  map[3][20].walkable = false;
  map[3][22].walkable = false;
  map[4][1].walkable = false;
  map[4][3].walkable = false;
  map[4][20].walkable = false;
  map[4][22].walkable = false;
  map[5][3].walkable = false;
  map[5][5].walkable = false;
  map[5][6].walkable = false;
  map[5][7].walkable = false;
  map[5][8].walkable = false;
  map[5][10].walkable = false;
  map[5][11].walkable = false;
  map[5][12].walkable = false;
  map[5][13].walkable = false;
  map[5][15].walkable = false;
  map[5][16].walkable = false;
  map[5][17].walkable = false;
  map[5][18].walkable = false;
  map[5][20].walkable = false;
  map[6][1].walkable = false;
  map[6][3].walkable = false;
  map[6][5].walkable = false;
  map[6][18].walkable = false;
  map[6][20].walkable = false;
  map[6][22].walkable = false;
  map[7][1].walkable = false;
  map[7][3].walkable = false;
  map[7][5].walkable = false;
  map[7][7].walkable = false;
  map[7][8].walkable = false;
  map[7][9].walkable = false;
  map[7][10].walkable = false;
  map[7][13].walkable = false;
  map[7][14].walkable = false;
  map[7][15].walkable = false;
  map[7][16].walkable = false;
  map[7][18].walkable = false;
  map[7][20].walkable = false;
  map[7][22].walkable = false;
  map[8][1].walkable = false;
  map[8][3].walkable = false;
  map[8][5].walkable = false;
  map[8][7].walkable = false;
  map[8][16].walkable = false;
  map[8][18].walkable = false;
  map[8][20].walkable = false;
  map[8][22].walkable = false;
  map[9][1].walkable = false;
  map[9][3].walkable = false;
  map[9][7].walkable = false;
  map[9][10].walkable = false;
  map[9][11].walkable = false;
  map[9][12].walkable = false;
  map[9][13].walkable = false;
  map[9][16].walkable = false;
  map[9][20].walkable = false;
  map[9][22].walkable = false;
  map[10][1].walkable = false;
  map[10][3].walkable = false;
  map[10][5].walkable = false;
  map[10][7].walkable = false;
  map[10][10].walkable = false;
  map[10][13].walkable = false;
  map[10][16].walkable = false;
  map[10][18].walkable = false;
  map[10][20].walkable = false;
  map[10][22].walkable = false;
  map[11][5].walkable = false;
  map[11][13].walkable = false;
  map[11][18].walkable = false;
  map[22][1].walkable = false;
  map[22][2].walkable = false;
  map[22][3].walkable = false;
  map[22][4].walkable = false;
  map[22][6].walkable = false;
  map[22][7].walkable = false;
  map[22][8].walkable = false;
  map[22][9].walkable = false;
  map[22][10].walkable = false;
  map[22][13].walkable = false;
  map[22][14].walkable = false;
  map[22][15].walkable = false;
  map[22][16].walkable = false;
  map[22][17].walkable = false;
  map[22][19].walkable = false;
  map[22][20].walkable = false;
  map[22][21].walkable = false;
  map[22][22].walkable = false;
  map[21][1].walkable = false;
  map[21][22].walkable = false;
  map[20][1].walkable = false;
  map[20][3].walkable = false;
  map[20][4].walkable = false;
  map[20][5].walkable = false;
  map[20][6].walkable = false;
  map[20][7].walkable = false;
  map[20][8].walkable = false;
  map[20][9].walkable = false;
  map[20][10].walkable = false;
  map[20][13].walkable = false;
  map[20][14].walkable = false;
  map[20][15].walkable = false;
  map[20][16].walkable = false;
  map[20][17].walkable = false;
  map[20][18].walkable = false;
  map[20][19].walkable = false;
  map[20][20].walkable = false;
  map[20][22].walkable = false;
  map[19][1].walkable = false;
  map[19][3].walkable = false;
  map[19][20].walkable = false;
  map[19][22].walkable = false;
  map[18][3].walkable = false;
  map[18][5].walkable = false;
  map[18][6].walkable = false;
  map[18][7].walkable = false;
  map[18][8].walkable = false;
  map[18][10].walkable = false;
  map[18][11].walkable = false;
  map[18][12].walkable = false;
  map[18][13].walkable = false;
  map[18][15].walkable = false;
  map[18][16].walkable = false;
  map[18][17].walkable = false;
  map[18][18].walkable = false;
  map[18][20].walkable = false;
  map[17][1].walkable = false;
  map[17][3].walkable = false;
  map[17][5].walkable = false;
  map[17][18].walkable = false;
  map[17][20].walkable = false;
  map[17][22].walkable = false;
  map[16][1].walkable = false;
  map[16][3].walkable = false;
  map[16][5].walkable = false;
  map[16][7].walkable = false;
  map[16][8].walkable = false;
  map[16][9].walkable = false;
  map[16][10].walkable = false;
  map[16][13].walkable = false;
  map[16][14].walkable = false;
  map[16][15].walkable = false;
  map[16][16].walkable = false;
  map[16][18].walkable = false;
  map[16][20].walkable = false;
  map[16][22].walkable = false;
  map[15][1].walkable = false;
  map[15][3].walkable = false;
  map[15][5].walkable = false;
  map[15][7].walkable = false;
  map[15][16].walkable = false;
  map[15][18].walkable = false;
  map[15][20].walkable = false;
  map[15][22].walkable = false;
  map[14][1].walkable = false;
  map[14][3].walkable = false;
  map[14][7].walkable = false;
  map[14][10].walkable = false;
  map[14][11].walkable = false;
  map[14][12].walkable = false;
  map[14][13].walkable = false;
  map[14][16].walkable = false;
  map[14][20].walkable = false;
  map[14][22].walkable = false;
  map[13][1].walkable = false;
  map[13][3].walkable = false;
  map[13][5].walkable = false;
  map[13][7].walkable = false;
  map[13][10].walkable = false;
  map[13][13].walkable = false;
  map[13][16].walkable = false;
  map[13][18].walkable = false;
  map[13][20].walkable = false;
  map[13][22].walkable = false;
  map[12][5].walkable = false;
  map[12][13].walkable = false;
  map[12][18].walkable = false;
  map[10][12].walkable = false;
  map[11][12].walkable = false;
  map[12][12].walkable = false;
  map[13][12].walkable = false;
  map[10][11].walkable = false;
  map[13][11].walkable = false;
  //temp false
  map[11][10].walkable = false;
  map[12][10].walkable = false;
  map[11][11].walkable = false;
  map[12][11].walkable = false;

  for (int dax = 0; dax < 24; dax++) {
    for (int dyx = 0; dyx < 24; dyx++) {
      if (!(map[dax][dyx].walkable)) {
        map[dax][dyx].stepped = map[dax][dyx].occupado = true;
        left -= 1;
      }
    }
  }
}