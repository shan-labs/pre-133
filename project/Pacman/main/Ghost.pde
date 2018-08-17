import java.util.ArrayDeque;

class Ghost {

  public PImage img;
  public int x;
  public int y;
  public ArrayDeque<Mnode> moves;
  public boolean edible;
  public String which;
  public int[][] possible = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} };
  public int time;
  public int speed;
  public Mnode pacmanPosition;
  public MazeSolver nexts;


  public Ghost(String shade) {
    img = loadImage(shade+".png");
    which = shade;
    moves = new ArrayDeque<Mnode>();
    time = 0;
    speed = 2;
    edible = true;
    nexts = new MazeSolver(map);
  }

  public Ghost(String shade, Mnode start) {
    this(shade);
    moves = new ArrayDeque<Mnode>();
    moves.addFirst(start);
  }

  void start(Mnode first) {
    moves.add(first);
  }

  void display(int i) {
    x = moves.peek().row;
    y = moves.peek().col;
    if (edible) {
      imageMode(CENTER);
      image(img, moves.peek().x, moves.peek().y, (img.width * .4)/2, (img.height * .4)/2);
    } else {
      tint(0, 153, 204);  // Tint blue
      image(img, moves.peek().x, moves.peek().y, (img.width * .4)/2, (img.height * .4)/2);
      noTint();
    }
    if (time%10 == 0) {
      update(i);
    }
    time++;
  }

  void update(int i) {
    if (i == 0) {
      scatter();
    }
    if (i == 1) {
      chase();
    }
  }

  void scatter() {
    switch (which) {
    case "red": 
      nexts.solve(moves.peek(), map[0][0]);
      break;
    case "yellow": 
      nexts.solve(moves.peek(), map[0][23]);
      break;
    case "blue": 
      nexts.solve(moves.peek(), map[23][0]);
      break;
    case "pink": 
      nexts.solve(moves.peek(), map[23][23]);
      break;
    }
    try {
      nexts.nexts.removeFirst();
      moves.addFirst(nexts.nexts.peek());
    }
    catch(Exception e) {
    }
  }

  void chase() {
    try {
      nexts.solve(moves.peek(), pacmanPosition);
      nexts.nexts.removeFirst();
      moves= Mnode.calculate(nexts.nexts.removeFirst(), pacmanPosition, speed);
    }
    catch(Exception e) {
    }
  }
}