import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import openfl.Assets;

import StoreItem;
import StoreArrows;

class StoreScene extends Scene {
	
	public override function begin() {
		backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		addGraphic(backdrop);
		var buyText:Text = new Text("Buy :", HXP.halfWidth - 100, 50, 0, 0, {size: 40});
		buyText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
		addGraphic(buyText);

		for (i in 0...StoreItem.itemnames.length) {
			add(new StoreItem(HXP.halfWidth, 200 + (i * 200), i));
			add(new StoreArrows(HXP.halfWidth, 200 + (i * 200), i));
		}
	}

	public override function update() {
		super.update();
		backdrop.y += 1;
	}

	private var backdrop:Backdrop;
}