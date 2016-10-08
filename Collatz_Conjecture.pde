
//Circulos rojos paralelos en series
// 1 | 2 | 4 |  8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 |  8192 | 16384 | 32768 | 65536 | 131072
// --|-|-|-----------------------------------------------
//   |   | 5 | 10 | 20 | 40 | 80 | 160 | 320 | 640 | 1280 | 2560 | 5120 | 10240 | 20480 | 40960 | 81920 | 163840
//   |   |   |    | 21 | 42 | 84 | 168 | 336 | 672 | 1344 | 2688 | 5376 | 10752 | 21504 | 43008 | 86016 | 172032
//   |   |   |    |    |    | 85 | 170 | 340 | 680 | 1360 | 2720 | 5440 | 10880 | 21760 | 43520 | 87040 | 174080
//   |   |   |    |    |    |    |     | 341 | 682 | 1364 | 2728 | 5456 | 10912 | 21824 | 43648 | 87296 | 174592
//   |   |   |    |    |    |    |     |     |     | 1365 | 2730 | 5460 | 10920 | 21840 | 43680 | 87360 | 174720
//   |   |   |    |    |    |    |     |     |     |      |      | 5461 | 10922 | 21844 | 43688 | 87376 | 174752
//   |   |   |    |    |    |    |     |     |     |      |      |      |       | 21845 | 43690 | 87380 | 174760
//   |   |   |    |    |    |    |     |     |     |      |      |      |       |       |       | 87381 | 174762




int i = 0;
int r = 5;
// Change the next 3 variables to see different parts of the representation:
//   startingPoint will be the point in the far left
//   scale will be, well, the scale
//   globalY will be the y-coordinate value of all nodes
int startingPoint = 0;
float scale = 0.005;
int globalY = 350;

Node node;
Table cadenas;
Table baseDatos;

void setup() {
  size(1200, 400);
  cadenas = loadTable("cadenas.csv", "header");
  baseDatos = loadTable("baseDatos.csv", "header");
};

void draw() {
  if (i > cadenas.getRowCount()) {
    noLoop();
  }
  TableRow row = baseDatos.getRow(i);
  node = new Node(row.getInt("n"));
  // This will show the node either as a dot, a written number or both:
  // node.show();
  node.calcLink();
  i++;
}

class Node {
  int x;
  int y;
  int num;
  Node(int n) {
    this.x = int((n - startingPoint) * scale);
    this.y = globalY;
    this.num = n;
  };
  void show() {
    // This shows the node as a black dot:
    // pushMatrix();
    // fill(0);
    // noStroke();
    // ellipse(this.x, this.y, r, r);
    // popMatrix();

    // This writes the number in the same x-coordinate it is represented (the y-coordinate is random to avoid as much overlap as possible quickly and easily):
    // pushMatrix();
    // fill(0);
    // stroke(0);
    // text(this.num, this.x, random(20, 380));
    // popMatrix();
  };
  void calcLink() {
    for (TableRow row : cadenas.rows()) {
      if (this.num == row.getInt("n")) {
        new Link(this.num, row.getInt("2n"), "red");
        new Link(this.num, row.getInt("3(n-1)"), "green");
      };
    };
  };
}

class Link {
  int n;
  int m;
  Link(int nInput, int mInput, String c) {
    if (nInput != 0 && mInput != 0) {
      this.n = nInput - startingPoint;
      this.m = mInput - startingPoint;
      this.show(c);
    }
  }
  void show(String c) {
    float o = this.n + this.m;
    o /= 2;
    float d = 2 * scale * abs(o - this.n);
    o *= scale;
    pushMatrix();
    noFill();
    if (c == "red") {
      stroke(200, 50, 50, 100);
    } else {
      stroke(50, 200, 50, 100);
    }
    arc(o, globalY, d, d, PI, TWO_PI);
    popMatrix();
  }
}
