class Planet {
	int id;
	String name, descr;
	float dst, spd, siz, rot;

	boolean active, locked;
	float sizMult = 0;

	Planet(int _id) {
		id = _id;
		// set the name and size
		switch(id) {
			case 0:
				name = "Mercury";
				siz = 4;
			break;
			case 1:
				name = "venus";
				siz = 5.5;
			break;
			case 2:
				name = "earth";
				siz = 4.5;
			break;
			case 3:
				name = "mars";
				siz = 3.5;
			break;
			case 4:
				name = "jupiter";
				siz = 8;
			break;
			case 5:
				name = "saturn";
				siz = 6.7;
			break;
			case 6:
				name = "uranus";
				siz = 6.3;
			break;
			case 7:
				name = "neptune";
				siz = 6.0;
			break;
			case 8:
				name = "pluto";
				siz = 4;
			break;
		}

		// set the distance to sun
		dst = 67 + 26 * (id+1);

		// set the orbiting speed
		spd = map(id,0,planets.length-1,0.5,0.3);
		spd += random(-0.1,0.1);

		// set the initial position of the planet
		rot = map(id,0,planets.length-1,0,360);
		rot += random(-25.0,25.0);

		// hard-coded check if planet is unlocked and has levels finished
		if (id<6) {
			descr = "locked";
			locked = true;
		} else {
			int levels = (int)random(7,30);
			int completed = (int)random(0,levels);
			if (levels == completed) descr = "completed";
			else descr = str(completed) + " of " + str(levels);
			locked = false;
		}

		// the planet is not selected per default
		active = false;

	}

	void update() {
		// let the planet orbit
		if (rot > 360) rot = 0;
		else rot -= spd;

		// check if the planet is selected
		if (activePlanet == id) active = true;
		else active = false;

		// draw the orbit ellipse and the planet
		draw();
	}

	void draw() {
		// draw orbit outline
		noFill();
		if (active) {
			stroke(yellow);
			sizMult = 2;
			strokeWeight(2);
		} else {
			stroke(white);
			sizMult = 1;
			strokeWeight(1);
		}

		pushMatrix();
		rotateX(radians(90));
		ellipse(0,0, dst * 2, dst * 2);
		popMatrix();

		// draw planet
		pushMatrix();
		rotateY(radians(rot));
		translate(dst,0,0);

		// draw planet outline
		if (active) {
			stroke(white);
			noFill();
			rotateY(radians(-rot));
			rotateX(radians(25));
			strokeWeight(3);
			// float offset = map(siz,2,20,10,1);
			ellipse(0,0, siz * sizMult * 3.5, siz * sizMult * 3.5);
			strokeWeight(1);
		}

		noStroke();
		if (active) fill(yellow);
		else fill(white);
		sphere(siz * sizMult);
		popMatrix();
	}
}