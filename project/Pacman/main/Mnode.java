import java.util.ArrayDeque;

public class Mnode implements Comparable<Mnode> {

  public int x;
  public int y;
  public int row;
  public int col;
  public boolean walkable;
  public boolean occupado;
  public boolean stepped;
  public PowerUp has;

  public Mnode(int dx, int dy, boolean clear) {
    x = dx;
    y = dy;
    walkable = clear;
    stepped = occupado = !(clear);
    has = null;
  }

  public Mnode(int r, int c, int dx, int dy, boolean clear) {
    this(dx, dy, clear);
    row = r;
    col = c;
  }

  public int compareTo(Mnode o) {
    return Math.abs(x - o.x) + Math.abs(y - o.y);
  }

  public String toString() {
    return "("+row+","+col+")";
  }
  public String coor() {
    return "("+x+","+y+")";
  }

  public static ArrayDeque<Mnode> calculate(Mnode s, Mnode e, int spd) {
    ArrayDeque<Mnode> moves = new ArrayDeque<Mnode>();
    double dist = Math.sqrt(((e.x - s.x) * (e.x - s.x)) + ((e.y - s.y) * (e.y - s.y)));
    double times = (double)(dist / spd);
    double incrx = (double)((e.x - s.x) / times)/2;
    double incry = (double)((e.y - s.y) / times)/2;
    boolean overshot = false;
    if (e.x > s.x) {
      overshot = true;
    }
    moves.addFirst(s);
    int t = 0;
    for (double nowx = s.x + incrx, nowy = s.y + incry; (Math.sqrt(((e.x - nowx) * (e.x - nowx)) + ((e.y - nowy) * (e.y - nowy))) > 5) && (t < times - 1); nowx += incrx, nowy += incry, t++) {
      moves.addLast(new Mnode((int)nowx, (int)nowy, true));
    }
    moves.addLast(e);
    return moves;
  }
}