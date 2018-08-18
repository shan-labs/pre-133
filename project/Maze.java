import java.util.*;

public class Maze {
  Location start, end;
  private char[][]maze;


  public Location getStart() {
    return start;
  }
  public Location getEnd() {
    return end;
  }

  public Maze(Mnode s, Mnode e) {
    maze = new char [24][24];
    for(int i = 0; i < 24; i++){
      for(int j = 0; j < 24; j++){
        maze[i][j] = ' ';
      }
    }

    end = new Location(e.row, e.col, null, 0, 0, false);
    int d = Math.abs(e.row -s.row) + Math.abs(s.col - e.col);
    start = new Location(s.row, s.col, null, 0, d, false);
  }

  public char get(int row, int col) {
    return maze[row][col];
  }
  public void set(int row, int col, char n) {
    maze[row][col] = n;
  }
}