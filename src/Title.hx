import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import openfl.Assets;

class Title extends Entity {

	public function new () {
		super(HXP.width / 2, (HXP.height / 2) - 400);

		var icon = new Image("graphics/playerShip1_green.png");
		icon.scale = 1;
		icon.angle = 45;

		icon.x += 180;
		icon.y -= 10;

		var txt = new Text("Spáááce");
		txt.size = 80;
		txt.x -= 30;
		txt.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;

		this.centerOrigin();
		txt.centerOrigin();
		icon.centerOrigin();

		this.addGraphic(txt);
		this.addGraphic(icon);

		this.layer = -5;
	}

}