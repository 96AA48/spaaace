import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Asteroid extends Entity {

	public function new (x:Float, y:Float) {
		super(x, y);

		var file = '';
		var tempRand = Math.floor(Math.random() * sprites.length);

		file += spritesTypes[Math.floor(Math.random() * 2)];
		file += sprites[tempRand][Math.floor(Math.random() * sprites[tempRand].length)];

		side = Math.random() * 1;
		angleSpeed = Math.random() * 3;
		speed = (Math.random() * 2) + 9;

		sprite = new Image("graphics/" + file); 

		graphic = sprite;
		
		setHitbox(sprite.width - 15, sprite.height);

		sprite.centerOrigin();

		type = "asteroid";

		layer = -2;
	}

	public override function update() {
		this.y += speed;

		if (this.y > HXP.height) {
			this.scene.remove(this);
		}

		this.centerOrigin();
		sprite.centerOrigin();

		if (side > .5)
			this.sprite.angle += angleSpeed;
		else
			this.sprite.angle -= angleSpeed;


		super.update();
	}
		private var spritesTypes:Array<String> = [
			"meteorBrown_",
			"meteorGrey_"
		];

		private var sprites:Array<Array<String>> = [
			[
				"med1.png",
				"med2.png"
			],
			[
				"big1.png",
				"big2.png",
				"big3.png",
				"big4.png"
			],
			[
				"small1.png",
				"small2.png"
			]
		];

		private var sprite:Image;

		private var side:Float;
		private var angleSpeed:Float;
		private var speed:Float;
}