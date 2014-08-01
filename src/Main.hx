import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end

	#if !android
		HXP.screen.scale = .5;
		HXP.resize(360, 640);
	#else
		HXP.resize(720, 1280);
	#end

		HXP.scene = new MenuScene();
	}

	public static function main() { new Main(); }

}