import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;

import MenuButton;
import Title;

class MenuScene extends Scene {

	public override function begin() {
		var play = new MenuButton(HXP.width / 2, HXP.height / 2, "Play!");
		var title = new Title(HXP.width / 2, (HXP.height / 2) - 400);
		var copy = new Text("By Bram \"96AA48\" van der Veen, 2014", HXP.width / 2, HXP.height - 50);

		copy.size = 22;
		copy.centerOrigin();

		add(title);
		add(play);
		addGraphic(copy);
	}
}