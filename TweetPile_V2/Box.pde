// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// PBox2D example

// A rectangular box
class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  String sentence;
  Boolean hit;
  color [] colors = new color[5];
  int colorindex;
  // Constructor
  Box(float x, float y, float w_, float h_, String sentence_) {
    w = w_;
    h = h_;
    sentence = sentence_;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    hit = false;
    
    //FONT COLORS
    colors[0] = color(255, 17, 105);
    colors[1] = color(17, 255, 31);
    colors[2] = color(255, 148, 17);
    colors[3] = color(255);
    colors[4] = color(17, 210, 255);
    colorindex = int(random(5));
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Drawing the box
  void display() {

    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(colors[colorindex]);
    //stroke(0);
    textFont(f);
    text(sentence, 0, 0, w, h);
    noFill();
    stroke(255);
    //    rect(0, 0, w, h);
    popMatrix();
  }

  Vec2 returnLocation() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    return pos;
  }

  boolean done() {
    // Is it off the bottom of the screen?
    if (hit) {
      killBody();
      return true;
    } 
    return false;
  }

  void collision() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height/3) {
      hit = true;
    }
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 5;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setUserData(this);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(0);
  }
}

