import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Star extends Entity {

	public function new(x:Float) {
		super(x, -4);

		graphic = Image.createRect(4,4, 0xBBBBBB);

		moveSpeed = Math.floor(Math.random() * 12);
	}

	public override function update() {
		this.y += moveSpeed;

		if (this.y > HXP.height + 4) {
			this.scene.remove(this);
		}
	}
 
	private var moveSpeed:Int;
}