import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import openfl.Assets;

class StoreItem extends Entity {

	public function new(x:Float, y:Float, type:Int) {
		super(x, y);

		which = type;

		button = new Image("graphics/buttonGreen.png");
		button.scale = 2;

		text = new Text(itemnames[type]);
		text.color = 0x000000;
		text.size = 40;
		text.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
		
		this.x += 120;

		setHitbox(button.width * 2, button.height * 2);
		
		text.centerOrigin();
		button.centerOrigin();
		this.centerOrigin();

		for (i in 0...items[type].length) {
			sprites[i] = new Image("graphics/" + items[type][i]);
			sprites[i].x = -350;
			sprites[i].centerOrigin();
		}

		if (type != 4) currentSprite = 1;
		else currentSprite = 0;

		this.addGraphic(sprites[currentSprite]);

		this.addGraphic(button);
		this.addGraphic(text);

	}

	public override function update() {
		super.update();

		graphic = sprites[currentSprite];

		this.addGraphic(button);
		this.addGraphic(text);
	}

	public function goLeft() {
		if (currentSprite != 0) {
			currentSprite -= 1;
		}
	}

	public function goRight() {
		if (currentSprite != items[which].length - 1) {
			currentSprite += 1;
		}
	}

	private var currentSprite:Int;
	private var which:Int;
	private var button:Image;
	private var sprites:Array<Image> = [];
	private var text:Text;

	public static var itemnames:Array<String> = [
		"Fat Jumper",
		"Speed Jumper",
		"X3 Jumper",
		"V2 Laser",
		"Heavy Laser"
	];

	private var items:Array<Array<String>> = [
		[
			"playerShip3_green.png",
			"playerShip3_blue.png",
			"playerShip3_orange.png"
		],
		[
			"playerShip1_green.png",
			"playerShip1_blue.png",
			"playerShip1_orange.png"
		],
		[
			"playerShip2_green.png",
			"playerShip2_blue.png",
			"playerShip2_orange.png"
		],
		[
			"laserGreen04.png",
			"laserGreen06.png",
			"laserBlue06.png"
		],
		[
			"laserBlue16.png"
		]
	];

	private var prices:Array<Array<Int>> = [
		[
			50000,
			50000,
			50000
		],
		[
			100000,
			100000,
			100000
		],
		[
			150000,
			150000,
			150000
		],
		[
			50000,
			100000
		],
		[
			150000
		]

	];



}