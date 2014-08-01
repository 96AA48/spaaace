import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Bullet extends Entity {

	public function new(x:Float, y:Float, ?heavylaser:Bool) {
		super(x, y);
		isHeavyLaser = heavylaser;

		if (!isHeavyLaser)
			which = Save.load().laser;
		else
			which = Save.load().heavy_laser;

		if (!isHeavyLaser) {			
			laser1 = new Image(laser[which][0]);
			laser2 = new Image(laser[which][1]);
		}
		else {
			laser1 = new Image(heavy_laser[which][0]);
			laser2 = new Image(heavy_laser[which][1]);
		}

		graphic = laser1;

		setHitboxTo(laser1);
		laser1.centerOrigin();
		laser2.centerOrigin();
		this.centerOrigin();

		if (!isHeavyLaser) {
			type = "bullet";
		}
		else {
			layer = -4;
			type = "heavybullet";

		}

	}

	public override function update() {
		super.update();
		
		this.y -= moveSpeed;

		timer -= HXP.elapsed;

		if (collide("asteroid", this.x, this.y) != null && !isHeavyLaser) {
			this.scene.remove(this);
		}
		else if (collide("asteroid", this.x, this.y) != null && isHeavyLaser) {
			if (this.moveSpeed > 5)
				this.moveSpeed -= 2;
		}

		if (timer < 0 || this.y < 200) {
			graphic = laser2;
		}

		if (this.y < 0) {
			this.scene.remove(this);
		}
	}

	private var laser:Array<Array<String>> = [
		[
			"graphics/laserGreen04.png",
			"graphics/laserGreen12.png"
		],
		[
			"graphics/laserBlue02.png",
			"graphics/laserBlue06.png"
		]
	];

	private var heavy_laser:Array<Array<String>> = [
		[
			"graphics/laserGreen06.png",
			"graphics/laserGreen10.png"
		],
		[
			"graphics/laserBlue15.png",
			"graphics/laserBlue16.png"
		]
	];

	private var laser1:Image;
	private var laser2:Image;
	private var isHeavyLaser:Bool = false;
	private var moveSpeed:Float = 20;

	public var which:Int;

	private var timer:Float = .5;
}