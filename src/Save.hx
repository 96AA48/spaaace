import com.haxepunk.Entity;
import com.haxepunk.utils.Data;

class Save extends Entity {

	public function new() {
		super();
		Data.load("save/savegame.save");
	}

	public static function save(what:String, data:Dynamic) {
		Data.write(what, data);
		Data.save("save/savegame.save", true);
	}

	public static function load() {
		var data = {
			"ship" : Data.readString("ship" , "playerShip3_green.png"),
			"ship_type" : Data.readInt("ship_type", 3),
			"ship_color" : Data.readInt("ship_color", 1),
			"laser" : Data.readString("laser", "laserGreen04.png"),
			"has_heavy_laser" : Data.readBool("heavy_laser", false),
			"money" : Data.readInt("money", 1000)
		};

		return data;
	}

}