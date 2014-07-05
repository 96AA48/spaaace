import com.haxepunk.Entity;
import com.haxepunk.HXP;
import Asteroid;

class Spawner extends Entity {
	public function new () {
		super();
	}

	public override function update() {
		spawnStarTime -= HXP.elapsed;
		spawnAsteroidTime -= HXP.elapsed;

		if (spawnAsteroidTime < 0) {
			this.scene.add(new Asteroid(HXP.width * Math.random(), -16));
			spawnAsteroidTime = 1.5;
		}

		if (spawnStarTime < 0) {
			this.scene.add(new Star(HXP.width * Math.random()));
			spawnStarTime = .5;
		}

		super.update();
	}

	private var spawnAsteroidTime:Float = 1.5;
	private var spawnStarTime:Float = .5;
}