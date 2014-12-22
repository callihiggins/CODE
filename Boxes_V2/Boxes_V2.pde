// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// PBox2D example

// Basic example of falling rectangles

import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// A reference to our box2d world
PBox2D box2d;

int counter;
String [] data;
PFont f;
boolean stop;
// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

void setup() {
  size(1280, 720, P3D);
  smooth();
  f = loadFont("Serif-18.vlw");
  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  data = loadStrings("data.txt");
  // Add a bunch of fixed boundaries
  boundaries.add(new BottomBoundary(0, height+10, width*2, 10));
  boundaries.add(new Boundary(0, -20, 40, height*2 + 40));
  boundaries.add(new Boundary(width, 0, 10, height*2));
}

void draw() {
  background(0);

  // Boxes fall from the top every so often
  if (random(5) < 0.1 && boxes.size()-1 < data.length && !stop) {
    Box p = new Box(random(0, width), 30, 600, 60, data[counter]);
    boxes.add(p);
    counter++;
    if (counter == data.length - 1) stop = true;
  }

  // We must always step through time!
  box2d.step();




  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    b.display();
    Vec2 v = b.returnLocation();
    float x = v.x;
    float y = v.y;

    if (b.done()) {
      boxes.remove(i);
      String sentence = b.sentence;
      String [] words = sentence.split(" ");
      
      for (int j=0; j < words.length; j++) {
        Box sb = new SmallBox(x,y, textWidth(words[j]), 20, words[j]);
        boxes.add(sb);
      }
    }
  }

  // Display all the boundaries
  for (Boundary wall : boundaries) {
    wall.display();
  }
}

// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  //  println(o1);

  if (o1.getClass() == Box.class && o2.getClass() == BottomBoundary.class ||   o1.getClass() == Box.class && o2.getClass() == SmallBox.class) {
    Box box = (Box) o1;
    box.collision();
  } else if (o1.getClass() == BottomBoundary.class && o2.getClass() == Box.class ||   o2.getClass() == Box.class && o1.getClass() == SmallBox.class) {
    Box box = (Box) o2;
    box.collision();
  }
}
// Objects stop touching each other
void endContact(Contact cp) {
}

