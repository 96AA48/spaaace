import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

import Player;
import Score;
import EnemyBullet;
import Save;

class Enemy extends Entity {

	public function new (x:Float, y:Float, clr:Int, eT:Int) {
		super(x, y);

		color = clr;
		enemyType = eT;

		#if flash
			bulletSound = new Sfx("audio/laser3.mp3");
		#else
			bulletSound = new Sfx("audio/laser3.wav");
		#end


		sprite = new Image("graphics/" + enemies[color] + enemyType + ".png");
		healthSprite = Image.createRect(sprite.width, 10, 0x00FF00);
		healthSprite.y -= 50;

		originalHealth = health = (enemyType * 2 * (color + 1));

		sprite.centerOrigin();
		healthSprite.centerOrigin();

		addGraphic(sprite);
		addGraphic(healthSprite);

		setHitbox(sprite.width, sprite.height);

		layer = -4;
	}

	private function assignLocation() {
		if (enemyType < 3) {
			arr = [
				Math.floor(Math.random() * (HXP.width - this.width)),
				Math.floor((Math.random() * 200) + 350)
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
				(Math.random() * 200) + 350
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
				(Math.random() * 200) + 350
			];	
		}

		return arr;
	}

	private function shoot() {
		if (shootTimer < 0) {
			if (enemyType != 3) {
				this.scene.add(new EnemyBullet(this.x, this.y + this.height));
			}
			else {
				this.scene.add(new EnemyBullet(this.x - 30, this.y + this.height));	
				this.scene.add(new EnemyBullet(this.x + 30, this.y + this.height));	
			}

			if (enemyType == 4) {
				shootTimer = 1;
			}
			else {
				shootTimer = 5;
			}

			bulletSound.play();
		}
	}

	public override function update() {
		turnTimer -= HXP.elapsed;
		shootTimer -= HXP.elapsed;
		this.centerOrigin();

		healthSprite.scaledWidth = (sprite.width / originalHealth) * health;
		
		if (this.x != loc[0] && this.y != loc[1] && !dying)
			this.moveTowards(loc[0], loc[1], moveSpeed);

		if (turnTimer < 0) {
			loc = assignLocation();

			if (enemyType == 2)
				turnTimer = 2;
			else if (enemyType == 3 || enemyType == 4)
				turnTimer = 1;
			else if (enemyType == 1 || enemyType == 5)
				turnTimer = .5;
		}

		if (enemyType > 2) {
			if (Math.random() < .1 && shootTimer < 0) {
				var player = this.scene.getInstance("player");
				if (this.x > player.left && this.x < player.right) {
					turnTimer = 1;
					loc = [this.x, this.y];
					shoot();
				}
			}
		}

		var bullet:Entity = collide("bullet", this.x, this.y);
		var heavybullet:Entity = this.collide("heavybullet", this.x, this.y);

		if (bullet != null) {
			if (Save.load().laser == 0)
				damage = 1;
			else if (Save.load().laser == 1) 
				damage = 1.25;
			else if (Save.load().laser == 2)
				damage = 1.5;
			health -= damage;
			var score:Array<Score> = [];
			this.scene.getClass(Score, score);

			score[0].add(1500);

			this.scene.remove(bullet);
		}
		else if (heavybullet != null) {
			this.health -= 2;
		}

		if (health <= 0) {
			die();
		}
	}

	private function die() {
		if (!died) {
			dying = true;
			died = true;
			this.visible = false;
			this.scene.add(new Explosion(this.x, this.y, this));
		}
	}
	
	private var enemies:Array<String> = [
		"enemyGreen",
		"enemyBlue",
		"enemyRed",
		"enemyBlack"
	];

	private var sprite:Image;
	private var healthSprite:Image;
	private var bulletSound:Sfx;

	private var color:Int;
	private var enemyType:Int;
	private var health:Float;
	private var originalHealth:Float;
	private var dying:Bool = false;
	private var died:Bool = false;
	private var damage:Float;

	private var arr:Array<Float>;
	private var antX:Float;

	private var turnTimer:Float = 0;
	private var shootTimer:Float = 0;
	private var moveSpeed:Int = 10;
	private var loc:Array<Float> = [];
}