class SmallBox extends Box {
  SmallBox(float x, float y, float w_, float h_, String sentence_) {
    super(x, y, w_, h_, sentence_);
  }

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
    fd.density = 1;
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
    body.setLinearVelocity(new Vec2(random(-15, 15), random(-15, -1)));
    body.setAngularVelocity(0);
  }
}

