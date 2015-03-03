PImage bg;
PFont fnt12, fnt18, fnt30;
color white, yellow;
PVector origin;

Planet[] planets = new Planet[9];
int activePlanet = 8;

void setup() {
	// setup the window and renderer
	size(720,405,P3D);
	bg = loadImage("bg.gif");
	fnt12 = createFont("FLYWRENCH12.ttf",16,false);
	fnt18 = createFont("FLYWRENCH18.ttf",18,false);
	fnt30 = createFont("FLYWRENCH30.ttf",32,false);
	white = #ffffff;
	yellow = #fff200;
	origin = new PVector(width / 2, height / 2, 0);

	// add planets
	for (int i=0; i<planets.length; i++) planets[i] = new Planet(i);
}

void draw() {
	hint(DISABLE_DEPTH_TEST);
	camera();
	noLights();
	image(bg,0,0);
	noSmooth();
	translate(origin.x,origin.y,origin.z);

	// draw planet name
	textFont(fnt30);
	textAlign(CENTER,BOTTOM);
	fill(white);
	int yPos = -height / 3;
	text(planets[activePlanet].name,0,yPos - 10);
	textFont(fnt12);
	text(planets[activePlanet].descr,0,yPos + 17);
	stroke(yellow);
	strokeWeight(2);
	line(-40,yPos,40, yPos);
	line(-40,yPos + 20,40, yPos +20);
	strokeWeight(1);

	hint(ENABLE_DEPTH_TEST);
	PVector camPos = new PVector(0, -180.0, 450.0);
	float camYOffset = 20;
	// ortho();
	camera(camPos.x, camPos.y, camPos.z, 0, camYOffset, 0, 0, 1, 0);

	// draw sun
	fill(yellow);
	noStroke();
	sphere(40);

	// draw axes
	stroke(white);
	line(0,100,0,0,-100,0);

	pushMatrix();
	rotateY(radians(45));
	line(-320,0,0, 320,0,0);
	line(0,0,-320, 0,0,320);
	popMatrix();

	// update planets
	for (Planet p : planets) p.update();
}

void keyReleased() {
	if (keyCode == DOWN || keyCode == RIGHT) {
		if (activePlanet < planets.length-1) activePlanet += 1;
	}

	if (keyCode == UP || keyCode == LEFT) {
		if (activePlanet > 0) activePlanet -= 1;
	}
}