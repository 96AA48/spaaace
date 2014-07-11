import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Bullet extends Entity {

	public function new(x:Float, y:Float) {
		super(x, y);

		laser1 = new Image("graphics/laserGreen04.png");
		laser2 = new Image("graphics/laserGreen12.png");

		graphic = laser1;

		setHitboxTo(laser1);

		type = "bullet";

	}

	public override function update() {
		super.update();
		
		this.y -= 20;

		timer -= HXP.elapsed;

		if (collide("asteroid", this.x, this.y) != null) {
			this.scene.remove(this);
		}

		if (timer < 0 || this.y < 200) {
			graphic = laser2;
		}

		if (this.y < 0) {
			this.scene.remove(this);
		}
	}

	private var laser1:Image;
	private var laser2:Image;

	private var timer:Float = .5;
}