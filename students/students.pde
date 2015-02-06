// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// PBox2D example

// Basic example of falling rectangles

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
PBox2D box2d;

int counter;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
// A list for all of our rectangles
ArrayList<Box> boxes;

void setup() {
  size(1280, 720);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // Create ArrayLists	
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(0, height, width*2, 10));
  boundaries.add(new Boundary(0, 20, 40, height*2 + 40));
  boundaries.add(new Boundary(width, 0, 10, height*2));


  //STARTING LOCATIONS
  Box p1 = new Box(width/3 - 100, height/3);
  boxes.add(p1);
  Box p2 = new Box(width/3, height/3 + 100);
  boxes.add(p2);
  Box p3 = new Box(width/3 + 200, height/3 + 125);
  boxes.add(p3);
  Box p4 = new Box(width/3 + 300, height/3 + 100);
  boxes.add(p4);
  Box p5 = new Box(width/3 + 400, height/3 + 75);
  boxes.add(p5);
  Box p6 = new Box(width/3 + 450, height/3 + 100);
  boxes.add(p6);
  Box p7 = new Box(width/3 + 600, height/3 + 125);
  boxes.add(p7);
  Box p8 = new Box(width/3 + 650, height/3 + 150);
  boxes.add(p8);
}

void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  // Boxes that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }
}

