import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Circle;
import com.haxepunk.masks.Hitbox;
import com.haxepunk.HXP;

import Enemy;
import Explosion;
import Spawner;
import Bullet;
import Save;

class Boss extends Entity {

	public function new (clr:Int) {

		color = clr;
		currentSprite = sprites[color];
		currentSprite.scale = 8;
		currentSprite.smooth = false;

		maxEnemies = Math.floor((color + 1) * 2);

		graphic = currentSprite;

		super(HXP.halfWidth - (currentSprite.width * 4), currentSprite.height * -8);

		this.mask = new Circle(currentSprite.width * 4);

		layer = -3;

		healthBarBackground = Image.createRect(350, 20, 0xFF0000);

		health = originalHealth = (color + 1) * 50;
		healthBar = Image.createRect(350, 20, 0x00FF00);
		
		this.addGraphic(healthBarBackground);
		this.addGraphic(healthBar);

		healthBarBackground.centerOrigin();
		healthBar.centerOrigin();

		healthBarBackground.x = healthBar.x = this.width / 2;
		healthBarBackground.y = healthBar.y = this.height - 100;

	}

	public override function update() {
		super.update();
		spawnTimer -= HXP.elapsed;
		explosionTimer -= HXP.elapsed;

		var enemies:Array<Enemy> = [];
		this.scene.getClass(Enemy, enemies);
 
		if (spawnTimer < 0 && enemies.length != maxEnemies && canSpawn) {
			this.scene.add(new Enemy(this.width / 2, 20, color, Math.floor(Math.random() * 4) + 1));
			spawnTimer = .75;
		}

		enemies = null;

		if (this.y < currentSprite.height * 8 * -.5)
			this.y += 2;
		else if (!dead)
			canSpawn = true;

		if (health > 0) healthBar.scaledWidth = (healthBar.width / originalHealth) * health;
		else {	
			dead = true;
			canSpawn = false;

			if (explosionTimer < 0 && counter != 100) {
				healthBarBackground.alpha = healthBar.alpha = currentSprite.alpha -= 0.01;
				this.scene.add(new Explosion(this.x + (Math.random() * currentSprite.width * 8), this.y + (Math.random() * currentSprite.height * 8) + 100, this.scene.getInstance("player")));
				explosionTimer = Math.random() * .2;
				counter++;
				var spawner:Array<Spawner> = [];
				this.scene.getClass(Spawner, spawner);
				spawner[0].sublevel = 3;
			}
			else if (counter == 100) {
				var spawner:Array<Spawner> = [];
				this.scene.getClass(Spawner, spawner);
				spawner[0].bossSpawned = false;

				this.scene.remove(this);
			}
		}

		var bullet:Entity = this.collide("bullet", this.x, this.y);

		if (bullet != null) {
			if (Save.load().laser == 0)
				damage = 1;
			else if (Save.load().laser == 1) 
				damage = 1.25;
			else if (Save.load().laser == 2)
				damage = 1.5;
			this.health -= damage;
			this.scene.remove(bullet);
		}
	}

	private var currentSprite:Image;

	private var sprites:Array<Image> = [
		new Image("graphics/ufoGreen.png"),
		new Image("graphics/ufoBlue.png"),
		new Image("graphics/ufoRed.png"),
		new Image("graphics/ufoYellow.png")
	];

	private var color:Int;
	private var health:Float;
	private var originalHealth:Float;
	private var healthBar:Image;
	private var healthBarBackground:Image;
	private var damage:Float;

	private var maxEnemies:Int;
	private var canSpawn:Bool = false;
	private var spawnTimer:Float = .75;
	private var explosionTimer:Float = 0;
	private var counter:Int = 0;
	private var dead:Bool = false;
}