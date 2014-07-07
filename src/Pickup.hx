import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

import Score;
import Lives;

class Pickup extends Entity {

	public function new (x:Float, y:Float) {
		super(x, y);

		#if flash
			sound = new Sfx("audio/powerUp6.mp3");
		#else
			sound = new Sfx("audio/powerUp6.wav");
		#end

		var tempRand = .9 /*Math.random()*/;

		if (tempRand < .15) 
			randType = 1;
		else if (tempRand > .15 && tempRand < .80)
			randType = 2;
		else
			randType = 0;

		rand = Math.floor(Math.random() * 3);

		graphic = currentSprite = sprites[randType][rand];

		if (Math.random() > .5)
			turnSpeed = -1 * (Math.random() * 4);
		else
			turnSpeed = 1 * (Math.random() * 4);

		setHitboxTo(currentSprite);

	}

	public override function update () {
		this.y += (Math.random() * 3) + 6;

		this.centerOrigin();
		currentSprite.centerOrigin();

		currentSprite.angle += turnSpeed;

		if (this.y > HXP.height) {
			this.scene.remove(this);
		}

		if (collide("player", this.x, this.y) != null) {
			var score:Array<Score> = [];
			this.scene.getClass(Score, score);

			//Shield pickup
			if (this.randType == 0) {
				var player:Array<Player> = [];
				this.scene.getClass(Player, player);
				player[0].shielded = true;
				player[0].shieldTimer = (rand + 1) * 3;
			}
			//"things" pickup
			else if (this.randType == 1) {
				var lives:Array<Lives> = [];
				this.scene.getClass(Lives, lives);
				for(i in 0...rand + 1)
					lives[0].remDamage();	
			}
			//Money pickup
			else if (this.randType == 2) {
				score[0].add(1000 * this.randType);
			}

			sound.play();
			this.scene.remove(this);
		}

	}

	private var sprites:Array<Array<Image>> = [
		[
			new Image("graphics/shield_bronze.png"),
			new Image("graphics/shield_silver.png"),
			new Image("graphics/shield_gold.png")
		],
		[
			new Image("graphics/things_bronze.png"),
			new Image("graphics/things_silver.png"),
			new Image("graphics/things_gold.png")
		],
		[
			new Image("graphics/star_bronze.png"),
			new Image("graphics/star_silver.png"),
			new Image("graphics/star_gold.png")
		]
	];

	private var turnSpeed:Float;
	private var currentSprite:Image;
	private var sound:Sfx;

	private var rand:Int;
	private var randType:Int;

}