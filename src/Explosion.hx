import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;

class Explosion extends Entity {

	public function new (x:Float, y:Float, e:Entity) {
		super(x, y);
		
		entity = e;

		sprite = new Spritemap("graphics/explosion.png", 49, 49, die);
		sprite.add("explosion", [0,1,2,3,4,5], 10);
		sprite.scale = 3;

		graphic = sprite;
		sprite.play("explosion");

		this.centerOrigin();
		sprite.centerOrigin();

		layer = -4;
	}

	private function die () {
		this.scene.remove(this);
		if (entity.type != "player")
			this.scene.remove(entity);
	}

	private var sprite:Spritemap;
	private var entity:Entity;

}