import java.util.*;

public class MazeSolver {
  public Maze maze;
  public Mnode [][] map;
  public ArrayDeque<Mnode> nexts;
  public int[][] moves = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} };

  public MazeSolver(Mnode [][] map) {
    this.map = map;
  }

  public void solve(Mnode s, Mnode e) {
    maze = new Maze(s, e);
    nexts = new ArrayDeque<Mnode>();
    solve(1);
  }

  public void solve(int i) {
    //System.out.println("SOLVER");
    Frontier storage;
    boolean aStar= true;
    storage = new PriorityQueueFrontier(false);
    storage.add(maze.getStart());
    int sr= maze.getStart().row();//start row
    int sc= maze.getStart().col();//start col
    int er= maze.getEnd().row();//end row
    int ec= maze.getEnd().col();//end col
    //System.out.println(sr+","+sc+","+er+","+ec);
    while (storage.hasNext()) {
      Location current = storage.next();
      //System.out.println("CURRENT: "+current);
      int row= current.row();
      int col= current.col();
      int dist= Math.abs(er- row)+ Math.abs(ec- col);
      //System.out.println("DIST: "+dist);
      if (dist == 0) {
        //System.out.println("END?");
        maze.set(er, ec, 'E');
        while (current != maze.getStart()) {
          //System.out.println("ADDED");
          current= current.previous();
          nexts.addFirst(map[current.row()][current.col()]);
          maze.set(current.row(), current.col(), '@');
        }
        maze.set(sr, sc, 'S');
        return;
      }
      int moved = 0;
      for (int[] move : moves) {
        try {
          int r = row + move[0];
          int c = col + move[1];
          if (maze.get(r, c) == ' ' && map[r][c].walkable == true) {
            int startDist= Math.abs(sr- r)+ Math.abs(sc- c);
            int endDist= Math.abs(er- r)+ Math.abs(ec- c);
            storage.add(new Location(r, c, current, startDist, endDist, aStar));
            maze.set(r, c, '?');
          }
        }
        catch (IndexOutOfBoundsException e) {
        }
      }
      char setter= (moved==0) ? '.' : '@';
      maze.set(row, col, setter);
    }
  }
}