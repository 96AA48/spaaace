import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.utils.Touch;
import com.haxepunk.graphics.Text;
import com.haxepunk.Sfx;
import openfl.Assets;

import Bullet;
import Lives;
import Score;
import Explosion;

class Player extends Entity {
	public function new() {
		super(HXP.halfWidth - 16, HXP.height - 200);
		baseSprite = new Image("graphics/playerShip1_green.png");
		shield = new Image("graphics/shield1.png");

		#if flash
			laser = new Sfx("audio/laser4.mp3");
		#else
			laser = new Sfx("audio/laser4.wav");
		#end

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
		fireEffectLeft.x = -30;
		fireEffectLeft.y = 24;

		fireEffectRight = fireEffectsRight[currentAnim];
		fireEffectRight.x = 19;
		fireEffectRight.y = 24;

		this.addGraphic(fireEffectLeft);
		this.addGraphic(fireEffectRight);

		setHitbox(99, 75);

		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("up", [Key.UP, Key.W]);
		Input.define("shoot", [Key.SPACE]);

		name = type = "player";

		this.centerOrigin();
		baseSprite.centerOrigin();

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

		if (Input.check("shoot")) {
			shoot();
		}

		Input.touchPoints(onTouch);
	}

	private function onTouch(touch:Touch) {
		if (touch.y < HXP.height - 100 && (touch.y > 700) && this.y > 0)
			this.moveTowards(touch.x - (this.width / 2), touch.y - (this.height * 2), moveSpeed * 1.5);
	}

	public function shoot() {
		if (this.y > 0) {
			var score:Array<Score> = [];

			this.scene.getClass(Score, score);

			score[0].rem(500);
			this.scene.add(new Bullet(this.x, this.y - this.height / 2));
			laser.play();
		}
	}

	public function die() {
		this.visible = false;

		this.scene.add(new Explosion(this.x, this.y, this));

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
		shieldTimer -= HXP.elapsed;

		if (shieldTimer < 0)
			shielded = false;

		if (animWait < 0) {

			if (currentAnim == 3)
				currentAnim = 0;

			fireEffectLeft = fireEffectsLeft[currentAnim];
			fireEffectLeft.x = -30;
			fireEffectLeft.y = 24;

			fireEffectRight = fireEffectsRight[currentAnim];
			fireEffectRight.x = 19;
			fireEffectRight.y = 24;

			graphic = baseSprite;
			this.addGraphic(fireEffectLeft);
			this.addGraphic(fireEffectRight);

			shield.centerOrigin();

			if (shielded)
				this.addGraphic(shield);

			currentAnim++;
			animWait = .75;
		}

		if ((hitPause > 0 && hitPause < .3) || (hitPause > .6 && hitPause < .9) || (hitPause > 1.2 && hitPause < 1.5)) {
			this.visible = false;
		}
		else {
			this.visible = true;	
		}

		if (collide("asteroid", this.x, this.y) != null && hitPause < 0 && !shielded) {
			var lives:Array<Lives> = [];
			this.scene.getClass(Lives, lives);
			lives[0].addDamage();
			hitPause = 1.5;
		}

		if (collide("enemybullet", this.x, this.y) != null && hitPause < 0 && !shielded) {
			var lives:Array<Lives> = [];
			this.scene.getClass(Lives, lives);
			lives[0].addDamage();
			hitPause = 1.5;
		}

		super.update();
	}

	private var baseSprite:Image;
	private var shield:Image;
	private var laser:Sfx;
	private var fireEffectsLeft:Array<Image> = [];
	private var fireEffectsRight:Array<Image> = [];


	private var fireEffectLeft:Image;
	private var fireEffectRight:Image;

	private var moveSpeed:Int = 7;
	private var hitPause:Float = 0;

	private var animWait:Float = .75;
	private var currentAnim:Int = 0;

	public var shielded:Bool = false;
	public var shieldTimer:Float = 1;
}