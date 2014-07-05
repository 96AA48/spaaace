import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Backdrop;

import Spawner;
import Player;
import Button;
import Enemy;

class MainScene extends Scene
{
	public override function begin()
	{
		var player = new Player();
		var button = new Button();
		var spawner = new Spawner();
		var backdrop = new Backdrop("graphics/darkPurple.png", true, true);
		var enemy = new Enemy(160, 100);

		addGraphic(backdrop);

		#if (android || ios)
			add(button);
		#end

		add(enemy);

		add(player);
		add(spawner);
		
	}
}