import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import openfl.Assets;

class StoreItem extends Entity {

	public function new(x:Float, y:Float, type:Int) {
		super(x, y);

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

		arrowLeft = new Image("graphics/fire05.png");
		arrowLeft.angle = 90;
		arrowLeft.x = -440;
		arrowLeft.centerOrigin();

		arrowRight = new Image("graphics/fire05.png");
		arrowRight.angle = -90;
		arrowRight.x = -260;
		arrowRight.centerOrigin();


		this.addGraphic(sprites[0]);

		this.addGraphic(arrowLeft);
		this.addGraphic(arrowRight);

		this.addGraphic(button);
		this.addGraphic(text);

	}

	private var button:Image;
	
	private var sprites:Array<Image> = [];
	private var arrowLeft:Image;
	private var arrowRight:Image;

	private var text:Text;

	public static var itemnames:Array<String> = [
		"Fat Jumper",
		"Speeder Jumper",
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