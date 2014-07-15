import com.haxepunk.Entity;
import com.haxepunk.utils.Data;

class Save extends Entity {

	public function new() {
		super();
		Data.load("savegame.save");
	}

	public static function save(what:String, data:Dynamic) {
		Data.write(what, data);
		Data.save("savegame.save", true);
	}

	public static function load() {
		var data = {
			"current_ship" : Data.readString("ship" , "playerShip3_green"),
			"current_laser" : Data.readString("laser", "laserGreen04.png"),
			"has_heavy_laser" : Data.readBool("heavy_laser", false)
		};

		return data;
	}

}