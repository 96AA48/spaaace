import com.haxepunk.Scene;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;

import StoreItem;

class StoreScene extends Scene {
	
	public override function begin() {
		backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		addGraphic(backdrop);

		for (i in 0...StoreItem.itemnames.length) {
			add(new StoreItem(HXP.halfWidth, 200 + (i * 200), i));
		}
	}

	public override function update() {
		super.update();
		backdrop.y += 1;
	}

	private var backdrop:Backdrop;
}