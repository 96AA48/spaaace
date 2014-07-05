import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.utils.Key;

import MainScene;


class MenuButton extends Entity {

	public function new (x:Float, y:Float, txt:String) {
		super(x, y);

		sprite = new Image("graphics/buttonGreen.png");
		sprite.scale = 2;

		setHitbox(sprite.width * 2, sprite.height * 2);
		
		text = new Text(txt);
		text.color = 0x000000;
		text.size = 40;
		
		text.centerOrigin();
		sprite.centerOrigin();
		this.centerOrigin();

		this.addGraphic(sprite);
		this.addGraphic(text);

		Input.define("enter", [Key.ENTER, Key.SPACE]);
	}

	public override function update() {
		Input.touchPoints(onTouch);

		if (Input.check("enter")) {
			HXP.scene = new MainScene();
		}
	}

	private function onTouch(touch:Touch) {
		if ((touch.x > this.left && touch.x < this.right) && (touch.y > this.top && touch.y < this.bottom)) {
			HXP.scene = new MainScene();
		}
	}

	private var txt:String;
	private var sprite:Image;
	public var text:Text;

}