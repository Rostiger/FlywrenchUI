class Planet {
	public int id;
	public String name, descr;
	public float dst, spd, siz, rot;

	boolean active = false;
	float sizMult = 0;

	void update() {
		if (rot > 360) rot = 0;
		else rot -= spd;
		if (activePlanet == id) active = true;
		else active = false;
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