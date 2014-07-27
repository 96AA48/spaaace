import com.haxepunk.Entity;
import com.haxepunk.utils.Data;

class Save extends Entity {

	public function new() {
		super();
	}

	public static function save(what:String, data:Dynamic) {
		Data.write(what, data);
		Data.save("save/savegame.save", true);
	}

	public static function load() {
		Data.load("save/savegame.save");
		var data = {
			"ship" : Data.readString("ship" , "playerShip3_green.png"),
			"ship_type" : Data.readInt("ship_type", 3),
			"ship_color" : Data.readInt("ship_color", 1),
			"laser" : Data.readInt("laser", 0),
			"has_heavy_laser" : Data.readBool("heavy_laser", false),
			"money" : Data.readInt("money", 1000),
			"overlay" : Data.readBool("overlay", true)
		};

		return data;
	}

	public static function reset() {

			Data.write("ship" , "playerShip3_green.png");
			Data.write("ship_type", 3);
			Data.write("ship_color", 1);
			Data.write("laser", "laserGreen04.png");
			Data.write("heavy_laser", false);
			Data.write("money", 1000);
			Data.write("overlay", true);

			Data.save("save/savegame.save", true);

			trace("Reset savefile");
	}

}