import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;

class Title extends Entity {

	public function new (x:Float, y:Float) {
		super(x, y);

		var icon = new Image("graphics/cursor.png");
		icon.scale = 3.5;
		icon.x += 200;

		var txt = new Text("Spaaace");
		txt.size = 80;
		txt.x -= 20;

		this.centerOrigin();
		txt.centerOrigin();
		icon.centerOrigin();

		this.addGraphic(txt);
		this.addGraphic(icon);
	}

}