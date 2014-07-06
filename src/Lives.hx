import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

import Player;

class Lives extends Entity {

	public function new () {
		baseSprite = new Image("graphics/playerShip1_green.png");
		sprite = [
			baseSprite,
			new Image("graphics/playerShip1_damage1.png"),
			new Image("graphics/playerShip1_damage2.png"),
			new Image("graphics/playerShip1_damage3.png")
		];

		baseSprite.scale = .75;

		for (i in 0...sprite.length) {
			sprite[i].scale = .75;
		}

		super(HXP.width - (baseSprite.width * .75 + 20), HXP.height - (baseSprite.height * .75 + 20));

		graphic = baseSprite;

		this.addGraphic(sprite[0]);


		damage = 0;

	}

	public inline function addDamage() {damage++;}

	public override function update() {
		graphic = baseSprite;
		this.addGraphic(sprite[damage]);
		if (damage > 3) {
			var player:Array<Player> = [];
			this.scene.getClass(Player, player);
			player[0].die();

			damage = 0;
		}
		super.update();
	}

	private var sprite:Array<Image> = [];
	private var baseSprite:Image;
	private var damage:Int;

}