import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Enemy extends Entity {

	public function new (x:Float, y:Float) {
		super(x, y);

		color = Math.floor(Math.random() * 3);
		enemyType = Math.floor(Math.random() * 5) + 1;

		sprite = new Image("graphics/" + enemies[color] + enemyType + ".png");

		graphic = sprite;

		setHitbox(sprite.width, sprite.height);

		layer = -1;
	}

	public override function update() {
		turnTimer -= HXP.elapsed;
		
		if (this.x != loc[0] && this.y != loc[1])
			this.moveTowards(loc[0], loc[1], moveSpeed);

		if (turnTimer < 0) {
			loc = assignLocation();

			if (enemyType == 3)
				turnTimer = 2;
			else
				turnTimer = 1;
		}
	}

	private function assignLocation() {
		var arr:Array<Float> = [
			Math.random() * (HXP.width - this.width),
			Math.random() * 400
		];

		return arr;
	}

	private var enemies:Array<String> = [
		"enemyBlack",
		"enemyGreen",
		"enemyBlue"
	];

	private var sprite:Image;

	private var color:Int;
	private var enemyType:Int;

	private var turnTimer:Float = 0;
	private var moveSpeed:Int = 10;
	private var loc:Array<Float> = [];
}