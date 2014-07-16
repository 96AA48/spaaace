import com.haxepunk.Entity;
import com.haxepunk.HXP;

import Enemy;
import Boss;
import Star;
import Pickup;
import Asteroid;

class Spawner extends Entity {

	public function new() {
		super();
	}

	public override function update() {
		enemyTimer -= HXP.elapsed;
		var enemies:Array<Enemy> = [];
		var bosses:Array<Boss> = [];
		this.scene.getClass(Enemy, enemies);
		this.scene.getClass(Boss, bosses);

		if (level != 4) {
			if (enemyType == 6) {sublevel++; enemyType = 1;}

			if (enemies.length < 1 && sublevel < 2) {
				if (enemyTimer < 0) {
					if (sublevel == 0)
						this.scene.add(new Enemy(HXP.halfWidth, -60, level, enemyType++));
					else {
						this.scene.add(new Enemy(HXP.halfWidth, -60, level, enemyType++));
						if (enemyType != 6) this.scene.add(new Enemy(HXP.halfWidth, -60, level, enemyType++));
						else this.scene.add(new Enemy(HXP.halfWidth, -60, level, enemyType - 1));
					}

				}
			}
			else {
				enemyTimer = 1;
			}

			if (sublevel == 2 && !bossSpawned && enemies.length == 0) {
				this.scene.add(new Boss(level));
				bossSpawned = true;
			}

			if (sublevel == 3 && !bossSpawned && bosses.length != 1) {
				level++; enemyType = 1; sublevel = 0; trace("Next level!");
			}
		}
		else {
			trace("YOU BEAT THE GAME!");
		}


		spawnStarTime -= HXP.elapsed;
		spawnAsteroidTime -= HXP.elapsed;
		spawnPickupTime -= HXP.elapsed;

		if (spawnAsteroidTime < 0) {
			this.scene.add(new Asteroid(HXP.width * Math.random(), -16));
			spawnAsteroidTime = .5;
		}

		if (spawnStarTime < 0) {
			this.scene.add(new Star(HXP.width * Math.random()));
			spawnStarTime = .5;
		}

		if (spawnPickupTime < 0) {
			this.scene.add(new Pickup(HXP.width * Math.random(), -50));
			spawnPickupTime = 5 * Math.random() + 5;
		}
	}

	private var level:Int = 0;
	public var sublevel:Int = 0;

	private var enemyTimer:Float = 1;
	private var enemyType:Int = 1;

	public var bossSpawned:Bool = false;

	private var spawnPickupTime:Float = 10;
	private var spawnAsteroidTime:Float = .5;
	private var spawnStarTime:Float = .5;
}