import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.utils.Input;
import openfl.Assets;

import MenuButton;
import Title;
import Spawner;
import MainScene;
import Save;

class MenuScene extends Scene {

	public override function begin() {
		backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		var play = new MenuButton(HXP.width / 2, HXP.height / 2, "Play!");
		var title = new Title();
		copy = new Text("By Bram \"96AA48\" van der Veen, 2014\nGraphics and Sfx by Kenney\nMusic by Jensan", HXP.width / 2, HXP.height - 50, {align: "center"});
		var spawner = new Spawner();

		copy.size = 22;
		copy.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;

		copy.centerOrigin();

		addGraphic(backdrop);
		add(spawner);

		add(title);
		add(play);
		addGraphic(copy);
	}

	public override function end() {
		this.removeAll();
		update();
	}

	public override function update() {
		super.update();
		backdrop.y += 1;

		if (Input.mousePressed) {
			if ((Input.mouseY > HXP.height - 200)) {
				Save.reset();
			}
		}
	}

	private var backdrop:Backdrop;
	private var copy:Text;
}