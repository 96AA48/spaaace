import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.HXP;
import Player;

class Button extends Entity {

	public function new() {
		super(10, HXP.height - (this.height + 60 * 2));
		
		sprite = new Image("graphics/laserRed08.png");
		sprite.scale = 2;
		graphic = sprite; 

		setHitbox(sprite.width * 2, sprite.height * 2);

		layer = -3;

	}

	public override function update() {
		Input.touchPoints(onTouch);
	}

	private function onTouch(touch:Touch) {
		if ((touch.x > this.x && touch.x < this.x + this.width) && (touch.y > this.y && touch.y < this.y + this.height)) {
			if (touch.pressed) {
				var players:Array<Player> = [];
				this.scene.getClass(Player, players);
				players[0].shoot();
			}
		}
	}

	private var sprite:Image;
}