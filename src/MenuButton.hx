import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.utils.Key;
import openfl.Assets;

import MainScene;
import MenuScene;


class MenuButton extends Entity {

	public function new (x:Float, y:Float, txt:String) {
		super(x, y);

		sprite = new Image("graphics/buttonGreen.png");
		sprite.scale = 2;

		setHitbox(sprite.width * 2, sprite.height * 2);
		
		text = new Text(txt);
		text.color = 0x000000;
		text.size = 40;
		text.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
		
		text.centerOrigin();
		sprite.centerOrigin();
		this.centerOrigin();

		this.addGraphic(sprite);
		this.addGraphic(text);

		this.layer = -5;

		Input.define("enter", [Key.ENTER, Key.SPACE]);
	}

	public override function update() {
		Input.touchPoints(onTouch);

		if (Input.mouseReleased) {
			if ((Input.mouseX > this.left && Input.mouseX < this.right) && (Input.mouseY > this.top && Input.mouseY < this.bottom)) {
				if (this.text.text != "Menu") {
					HXP.scene = new MainScene();
				}
				else  {
					HXP.scene = new MenuScene();
				}
			}
		}

		if (Input.check("enter")) {
			if (this.text.text != "Menu") {
				HXP.scene = new MainScene();
			}
			else  {
				HXP.scene = new MenuScene();
			}
		}
	}

	private function onTouch(touch:Touch) {
		if ((touch.x > this.left && touch.x < this.right) && (touch.y > this.top && touch.y < this.bottom)) {
			if (this.text.text != "Menu") {
				HXP.scene = new MainScene();
			}
			else  {
				HXP.scene = new MenuScene();
			}
		}
	}

	private var txt:String;
	private var sprite:Image;
	private var text:Text;

}