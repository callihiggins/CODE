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

Agent[] agentsBlue = new Agent[1500]; // Make more than we display so we can increase if needed
Agent[] agentsRed = new Agent[500]; // Aiming for 2000 total agents, 75% Blue, 25% Red

//Start out with 1000 agents, 75% Blue, 25% Red
int agentsCountBlue = 750;
int agentsCountRed = 250;

float noiseScale = 100;
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 0.3;


void setup() {
  size(1280, 800, P2D);
  smooth();
  //Adjust colors if needed
  for (int i=0; i<agentsRed.length; i++) agentsRed[i] = new Agent(color(255, 0, 0, agentsAlpha), .2, 10);
  for (int i=0; i<agentsBlue.length; i++) agentsBlue[i] = new Agent(color(0, 0, 255, agentsAlpha), .6, 20);
}

void draw() {
  fill(255, overlayAlpha);
  noStroke();
  rect(0, 0, width, height);

  //draw agents
  for (int i=0; i<agentsCountRed; i++) agentsRed[i].update();
  for (int i=0; i<agentsCountBlue; i++) agentsBlue[i].update();

 // TURN ME ON TO INCREASE NUMBER OF RIBBONS OVER TIME
 // if (agentsCountRed < (agentsRed.length-11))  agentsCountRed += 10;
 // if (agentsCountBlue < (agentsBlue.length-11))  agentsCountBlue += 10;
}

void keyReleased() {
  // if (key=='s' || key=='S') saveFrame(timestamp()+".png");
  if (key == DELETE || key == BACKSPACE) background(255);
} 




