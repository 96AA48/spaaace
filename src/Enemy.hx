import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

import Player;
import Score;

class Enemy extends Entity {

	public function new (x:Float, y:Float) {
		super(x, y);

		color = Math.floor(Math.random() * 4);
		enemyType = Math.floor(Math.random() * 5) + 1;


		sprite = new Image("graphics/" + enemies[color] + enemyType + ".png");
		healthSprite = Image.createRect(sprite.width, 10, 0x00FF00);
		healthSprite.y -= 50;

		originalHealth = health = (enemyType * 2 * color);

		sprite.centerOrigin();
		healthSprite.centerOrigin();

		addGraphic(sprite);
		addGraphic(healthSprite);

		setHitbox(sprite.width, sprite.height);

		layer = -1;
	}


	private function assignLocation() {
		if (enemyType <= 2) {
			arr = [
				Math.floor(Math.random() * (HXP.width - this.width)),
				Math.floor(Math.random() * 400)
			];
		}
		else if (enemyType >= 3 && enemyType <= 4) {
			var player:Array<Player> = [];
			this.scene.getClass(Player, player);

			if (Math.random() * 1 > .5)
				antX = player[0].x;
			else 
				antX = Math.random() * HXP.width;

			arr = [
				antX,
				Math.random() * 400
			];
		}
		else {
			var player:Array<Player> = [];
			this.scene.getClass(Player, player);
			
			if (Math.random() * 1 > .5)
				antX = player[0].x;
			else 
				antX = Math.random() * HXP.width;

			if (Math.random() * 1 > .5)
				antX -= this.width;
			else
				antX += this.width;

			arr = [
				antX,
				Math.random() * 400
			];	
		}

		return arr;
	}

	public override function update() {
		turnTimer -= HXP.elapsed;
		this.centerOrigin();

		healthSprite.scaledWidth = (sprite.width / originalHealth) * health;
		
		if (this.x != loc[0] && this.y != loc[1])
			this.moveTowards(loc[0], loc[1], moveSpeed);

		if (turnTimer < 0) {
			loc = assignLocation();

			if (enemyType == 2)
				turnTimer = 2;
			else if (enemyType == 3 || enemyType == 4)
				turnTimer = 1;
			else if (enemyType == 1)
				turnTimer = .5;
		}

		var bullet:Entity = collide("bullet", this.x, this.y);

		if (bullet != null) {
			health -= 1;
			var score:Array<Score> = [];
			this.scene.getClass(Score, score);

			score[0].add(15);

			this.scene.remove(bullet);
		}

		if (health == 0)
			this.scene.remove(this);
	}
	
	private var enemies:Array<String> = [
		"enemyGreen",
		"enemyBlue",
		"enemyRed",
		"enemyBlack"
	];

	private var sprite:Image;
	private var healthSprite:Image;

	private var color:Int;
	private var enemyType:Int;
	private var health:Int;
	private var originalHealth:Int;

	private var arr:Array<Float>;
	private var antX:Float;

	private var turnTimer:Float = 0;
	private var moveSpeed:Int = 10;
	private var loc:Array<Float> = [];
}