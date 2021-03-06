// M_1_5_03_TOOL.pde
// Agent.pde, GUI.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ------ agents ------
Agent[] agents = new Agent[10000]; // create more ... to fit max slider agentsCount
int agentsCount = 4000;
float noiseScale = 100, noiseStrength = 10, noiseZRange = 0.4;
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 0.3;


void setup() {
  size(1280, 800, P2D);
  smooth();

  //Red agents at 75%
  for (int i=0; i<(agents.length * .75); i++) agents[i] = new Agent(color(255, 0, 0, agentsAlpha));
  //Blue agents at 25%
  for (int i=0; i<(agents.length * .25); i++) agents[i] = new Agent(color(0, 0, 255, agentsAlpha));
}

void draw() {
  fill(255, overlayAlpha);
  noStroke();
  rect(0, 0, width, height);

  //draw agents
  for (int i=0; i<agentsCount; i++) agents[i].update();

 // TURN ME ON TO INCREASE NUMBER OF RIBBONS OVER TIME
 // if (agentsCount < (agents.length-11))  agentsCount += 10;
}

void keyReleased() {
  // if (key=='s' || key=='S') saveFrame(timestamp()+".png");
  if (key == DELETE || key == BACKSPACE) background(255);
} 




