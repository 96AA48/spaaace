import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Bullet extends Entity {

	public function new(x:Float, y:Float, ?isHeavyLaser:Bool) {
		super(x, y);

		which = Save.load().laser;

		laser1 = new Image(laser[which][0]);
		laser2 = new Image(laser[which][1]);

		graphic = laser1;

		setHitboxTo(laser1);
		laser1.centerOrigin();
		laser2.centerOrigin();
		this.centerOrigin();

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

	private var laser:Array<Array<String>> = [
		[
			"graphics/laserGreen04.png",
			"graphics/laserGreen12.png"
		],
		[
			"graphics/laserGreen10.png",
			"graphics/laserGreen06.png"
		],
		[
			"graphics/laserBlue02.png",
			"graphics/laserBlue06.png"
		]
	];

	private var laser1:Image;
	private var laser2:Image;

	public var which:Int;

	private var timer:Float = .5;
}