import com.haxepunk.Entity;
import com.haxepunk.HXP;

import Asteroid;
import Enemy;

class Spawner extends Entity {
	public function new () {
		super();
	}

	public override function update() {
		spawnStarTime -= HXP.elapsed;
		spawnAsteroidTime -= HXP.elapsed;
		spawnEnemyTime -= HXP.elapsed;

		if (spawnAsteroidTime < 0) {
			this.scene.add(new Asteroid(HXP.width * Math.random(), -16));
			spawnAsteroidTime = .5;
		}

		if (spawnStarTime < 0) {
			this.scene.add(new Star(HXP.width * Math.random()));
			spawnStarTime = .5;
		}

		if (spawnEnemyTime < 0 && this.scene.getInstance("player") != null) {
			var enemies:Array<Entity> = [];
			this.scene.getClass(Enemy, enemies);

			if (enemies[0] == null) {
				this.scene.add(new Enemy(HXP.halfWidth, -50));
			}

			spawnEnemyTime = 5;
		}

		super.update();
	}

	private var spawnAsteroidTime:Float = .5;
	private var spawnStarTime:Float = .5;
	private var spawnEnemyTime:Float = 5;
}