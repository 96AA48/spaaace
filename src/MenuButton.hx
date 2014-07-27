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

		this.layer = -11;

		Input.define("enter", [Key.ENTER, Key.SPACE]);
	}

	public override function update() {

		if (Input.mouseReleased) {
			if ((Input.mouseX > this.left && Input.mouseX < this.right) && (Input.mouseY > this.top && Input.mouseY < this.bottom) || Input.pressed("enter")) {
				if (this.text.text == "Retry" || this.text.text == "Play!") {
					HXP.scene = null;
					Assets.cache.clear();
					HXP.scene = new MainScene();
				}
				else if (this.text.text == "Store") {
					HXP.scene = null;
					Assets.cache.clear();
					HXP.scene = new StoreScene();
				}
				else  {
					HXP.scene = null;
					Assets.cache.clear();
					HXP.scene = new MenuScene();
				}
			}
		}
	}

	private var txt:String;
	private var sprite:Image;
	private var text:Text;

}