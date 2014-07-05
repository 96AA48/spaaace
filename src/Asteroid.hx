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

		sprite = new Image("graphics/" + file); 

		graphic = sprite;
		
		sprite.centerOrigin();


		setHitbox(sprite.width, sprite.height);

		type = "asteroid";

		layer = -2;
	}

	public override function update() {
		this.y += 3;

		if (this.y > HXP.height) {
			this.scene.remove(this);
		}

		this.originX = Math.floor(sprite.width / 2);
		this.originY = Math.floor(sprite.height / 2);

		this.sprite.angle += 3;


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
}