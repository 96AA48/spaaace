import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Circle;
import com.haxepunk.masks.Hitbox;
import com.haxepunk.HXP;

import Enemy;

class Boss extends Entity {

	public function new () {

		var color:Int = Math.floor(Math.random() * 4);
		currentSprite = sprites[color];
		currentSprite.scale = 8;
		currentSprite.smooth = false;

		maxEnemies = Math.floor(Math.random() * (color + 1) * 4);

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
		var enemies:Array<Enemy> = [];
		this.scene.getClass(Enemy, enemies);

		if (spawnTimer < 0 && enemies.length != maxEnemies) {
			this.scene.add(new Enemy(this.width / 2, this.height / 2));
			spawnTimer = .75;
		}

		enemies = null;

		if (this.y < currentSprite.height * 8 * -.5)
			this.y += 2;

		healthBar.scaledWidth = (healthBar.width / originalHealth) * health;

		var bullet:Entity = this.collide("bullet", this.x, this.y);

		if (bullet != null) {
			this.health -= 1;
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

	private var health:Int;
	private var originalHealth:Int;
	private var healthBar:Image;
	private var healthBarBackground:Image;

	private var maxEnemies:Int;
	private var spawnTimer:Float = .75;

}