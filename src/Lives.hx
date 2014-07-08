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

		liveBar = Image.createRect(Math.floor(baseSprite.width * .75), 10, 0x00FF00);
		liveBar.y += 65;

		baseSprite.scale = .75;

		for (i in 0...sprite.length) {
			sprite[i].scale = .75;
		}

		super(HXP.width - (baseSprite.width * .75 + 20), 10);

		graphic = baseSprite;

		this.addGraphic(sprite[0]);
		this.addGraphic(liveBar);


		damage = 0;

	}

	public inline function addDamage() {damage++;}
	public inline function remDamage() {if (damage != 0) damage--;}

	public override function update() {
		graphic = baseSprite;
		this.addGraphic(sprite[damage]);

		liveBar.scaledWidth = (liveBar.width / 4) * (4 - damage);

		this.addGraphic(liveBar);

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
	private var liveBar:Image;
	private var damage:Int;

}