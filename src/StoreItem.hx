import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;

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

		description = new Text(itemDescription[type][1], 0, 0, 550);
		description.wordWrap = true;
		description.color = 0xFFFFFF;
		description.size = 22;
		description.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;

		description.x -= 450;
		description.y += 50;

		setHitbox(button.width * 2, button.height * 2);
		
		text.centerOrigin();
		button.centerOrigin();
		this.centerOrigin();

		for (i in 0...items[type].length) {
			sprites[i] = new Image("graphics/" + items[type][i]);
			sprites[i].x = -350;
			sprites[i].centerOrigin();
		}

		currentSprite = 1;

		this.addGraphic(sprites[currentSprite]);

		this.addGraphic(button);
		this.addGraphic(text);
		this.addGraphic(description);

	}

	public override function update() {
		super.update();
		
		description.wordWrap = true;
		description.text = itemDescription[which][currentSprite] + " $" + prices[which][currentSprite];

		graphic = sprites[currentSprite];

		this.addGraphic(button);
		this.addGraphic(text);
		this.addGraphic(description);

		if (Input.mouseReleased) {
			if ((Input.mouseX > this.left && Input.mouseX < this.right) && (Input.mouseY > this.top && Input.mouseY < this.bottom)) {
				buy();
			}
		}
	}

	private function buy() {
		var save = Save.load();
		if (save.money >= prices[which][currentSprite]) {
			if (which <= 2) {
				if (which == 0)
					Save.save("ship_type", 3);
				else if (which == 1) 
					Save.save("ship_type", 1);
				else
					Save.save("ship_type", 2);
			
				Save.save("ship", items[which][currentSprite]);
				Save.save("ship_color", currentSprite);
			}
			else {
				if (which == 4) 
					Save.save("heavy_laser", currentSprite);
				else
					Save.save("laser", currentSprite);
			}

			Save.save("money", save.money - prices[which][currentSprite]);
			trace("Bought something");
		}
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
	private var description:Text;

	public static var itemnames:Array<String> = [
		"Fat Jumper",
		"Speed Jumper",
		"X3 Jumper",
		"V2 Laser",
		"Heavy Laser"
	];

	public var items:Array<Array<String>> = [
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
			"laserBlue06.png"
		],
		[
			"laserGreen06.png",
			"laserBlue16.png"
		]
	];

	private var itemDescription:Array<Array<String>> = [
		[
			"The Fat Jumper is the slowest craft, but the strongest.\nIt has 1 canon.",
			"The Fat Jumper is the slowest craft, but the strongest.\nIt has 1 canon & some extra health (1).",
			"The Fat Jumper is the slowest craft, but the strongest.\nIt has 1 canon & some extra health (2)."
		],
		[
			"The Speed Jumper is slightly faster & has slightly less health.\nHas 2 canons.",
			"The Speed Jumper is slightly faster & has slightly less health.\nHas 2 canons & extra health (1).",
			"The Speed Jumper is slightly faster & has slightly less health.\nHas 2 canons & extra health (2)."
		],
		[
			"The X3 is the fastest craft, but with the least health.\nIt has 3 laser canons.",
			"The X3 is the fastest craft, but with the least health.\nIt has 3 laser canons & some extra health (1).",
			"The X3 is the fastest craft, but with the least health.\nIt has 3 laser canons & some extra health (2).",
		],
		[
			"This is the laser you start with, it's decent & does 1 damage.",
			"This laser does the same amount of damage as you're first, but moves slighly faster."
		],
		[
			"This heavy laser is the strongest laser, it serves as a secondary. To use, hold the shoot button for a few seconds & then release.",
			"This heavy laser is the strongest laser, it serves as a secondary. To use, hold the shoot button for a few seconds & then release."
		]
	];

	private var prices:Array<Array<Int>> = [
		[
			50000,
			150000,
			200000
		],
		[
			250000,
			300000,
			350000
		],
		[
			400000,
			450000,
			500000
		],
		[
			100000,
			150000
		],
		[
			100000,
			200000
		]

	];



}