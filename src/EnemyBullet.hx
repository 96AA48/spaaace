import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class EnemyBullet extends Entity {

	public function new (x:Float, y:Float) {
		super(x, y);

		sprite = [
			new Image("graphics/laserRed14.png"),
			new Image("graphics/laserRed16.png")
		];

		for (i in 0...sprite.length) {
			sprite[i].angle = 180;
			sprite[i].centerOrigin();
		}

		setHitboxTo(sprite[0]);

		graphic = sprite[0];

		type = "enemybullet";
	}

	public override function update() {
		super.update();
		timer -= HXP.elapsed;

		this.centerOrigin();

		this.y += 10;

		if (timer < 0) {
			graphic = sprite[1];
		}

		if (this.y > HXP.height) {
			this.scene.remove(this);
		}
	}

	private var sprite:Array<Image>;
	private var timer:Float = .5;
}