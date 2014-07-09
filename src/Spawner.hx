import com.haxepunk.Entity;
import com.haxepunk.HXP;

import Enemy;
import Boss;

class Spawner extends Entity {

	public function new() {
		super(0,0);

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

			if (sublevel == 2 && !bossSpawned) {
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
	}

	private var level:Int = 0;
	public var sublevel:Int = 0;

	private var enemyTimer:Float = 1;
	private var enemyType:Int = 1;

	public var bossSpawned:Bool = false;
}