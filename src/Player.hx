import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.utils.Touch;
import com.haxepunk.graphics.Text;
import openfl.Assets;

import Bullet;
import Lives;
import Score;

class Player extends Entity {
	public function new() {
		super(HXP.halfWidth - 16, HXP.height - 200);
		baseSprite = new Image("graphics/playerShip1_green.png");

		graphic = baseSprite;

		fireEffectsLeft = [
			new Image("graphics/fire13.png"),
			new Image("graphics/fire16.png"),
			new Image("graphics/fire17.png"),
		];

		fireEffectsRight = [
			new Image("graphics/fire13.png"),
			new Image("graphics/fire16.png"),
			new Image("graphics/fire17.png"),
		];

		fireEffectLeft = fireEffectsLeft[currentAnim];
		fireEffectLeft.x = 17;
		fireEffectLeft.y = 55;

		fireEffectRight = fireEffectsRight[currentAnim];
		fireEffectRight.x = 67;
		fireEffectRight.y = 55;


		this.addGraphic(fireEffectLeft);
		this.addGraphic(fireEffectRight);

		setHitbox(99, 75);

		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("up", [Key.UP, Key.W]);
		Input.define("shoot", [Key.SPACE]);

		name = type = "player";

		layer = -1;

	}	

	private function handleInput() {
		if (Input.check("left") && this.left > 0) {
			this.x -= moveSpeed;
		}
		if (Input.check("right") && this.right < HXP.width) {
			this.x += moveSpeed;
		}
		if (Input.check("down") && this.bottom < HXP.height && this.bottom > 0) {
			this.y += moveSpeed;
		}
		if (Input.check("up") && this.top > 700) {
			this.y -= moveSpeed;
		}

		if (Input.pressed("shoot")) {
			shoot();
		}

		Input.touchPoints(onTouch);
	}

	private function onTouch(touch:Touch) {
		if (touch.y < HXP.height - 100)
			this.moveTowards(touch.x - (this.width / 2), touch.y - (this.height * 2), moveSpeed * 1.5);
	}

	public function shoot() {
		var score:Array<Score> = [];

		this.scene.getClass(Score, score);

		score[0].rem(5);

		this.scene.add(new Bullet(this.x + this.width / 2, this.y));	
	}

	public function die() {
		this.visible = false;
		this.x = HXP.halfWidth;
		this.y = -200;
		var txt:Text = new Text("You died!", HXP.halfWidth - 225, HXP.halfHeight - 250, 500, 50, {size: 100});
		txt.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;

		this.scene.addGraphic(txt);
		this.scene.add(new MenuButton(HXP.halfWidth, HXP.halfHeight - 50, "Retry?"));
		this.scene.add(new MenuButton(HXP.halfWidth, HXP.halfHeight + 50, "Menu"));
	}

	public override function update() {
		handleInput();
		hitPause -= HXP.elapsed;
		animWait -= HXP.elapsed;

		if (animWait < 0) {

			if (currentAnim == 3)
				currentAnim = 0;

			fireEffectLeft = fireEffectsLeft[currentAnim];
			fireEffectLeft.x = 17;
			fireEffectLeft.y = 60;

			fireEffectRight = fireEffectsRight[currentAnim];
			fireEffectRight.x = 67;
			fireEffectRight.y = 60;

			graphic = baseSprite;
			this.addGraphic(fireEffectLeft);
			this.addGraphic(fireEffectRight);

			currentAnim++;
			animWait = .75;
		}

		if (collide("asteroid", this.x, this.y) != null && hitPause < 0) {
			var lives:Array<Lives> = [];
			this.scene.getClass(Lives, lives);
			lives[0].addDamage();
			hitPause = 1.5;
		}

		super.update();
	}

	private var baseSprite:Image;
	private var fireEffectsLeft:Array<Image> = [];
	private var fireEffectsRight:Array<Image> = [];


	private var fireEffectLeft:Image;
	private var fireEffectRight:Image;

	private var moveSpeed:Int = 7;
	private var hitPause:Float = 1.5;

	private var animWait:Float = .75;
	private var currentAnim:Int = 0;
}