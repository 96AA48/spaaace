import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.utils.Touch;

import Bullet;

class Player extends Entity {
	public function new() {
		super(HXP.halfWidth - 16, HXP.height - 200);

		graphic = new Image("graphics/playerShip1_green.png");

		setHitbox(99, 75);

		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("down", [Key.DOWN, Key.S]);
		Input.define("up", [Key.UP, Key.W]);
		Input.define("shoot", [Key.SPACE]);

		type = "player";

		layer = -1;

	}	

	private function handleInput() {
		if (Input.check("left") && this.left > 0) {
			this.x -= moveSpeed;
		}
		if (Input.check("right") && this.right < HXP.width) {
			this.x += moveSpeed;
		}
		if (Input.check("down") && this.bottom < HXP.height) {
			this.y += moveSpeed;
		}
		if (Input.check("up") && this.top > 0) {
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
		this.scene.add(new Bullet(this.x + this.width / 2, this.y));	
	}

	public override function update() {
		handleInput();

		var asteroid = collide("asteroid", this.x, this.y);

		if (asteroid != null) {
			trace(asteroid);
		}

		super.update();
	}

	private var moveSpeed:Int = 5;
}