import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import openfl.Assets;

import StoreItem;
import StoreArrows;

import Save;

class StoreScene extends Scene {
	
	public override function begin() {
		backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		addGraphic(backdrop);
		buyText = new Text("$" + Save.load().money + ", Buy :", HXP.halfWidth - 100, 50, 0, 0, {size: 40});
		buyText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
		addGraphic(buyText);

		for (i in 0...StoreItem.itemnames.length) {
			add(new StoreItem(HXP.halfWidth, 200 + (i * 200), i));
			add(new StoreArrows(HXP.halfWidth, 200 + (i * 200), i));
		}

		this.add(new MenuButton(HXP.halfWidth - 220, HXP.height - 50, "Retry"));
		this.add(new MenuButton(HXP.halfWidth + 220, HXP.height - 50, "Menu"));
	}

	public override function update() {
		super.update();
		buyText.text = "$" + Save.load().money + ", Buy :";
		backdrop.y += 1;
	}

	private var backdrop:Backdrop;
	private var buyText:Text;
}
