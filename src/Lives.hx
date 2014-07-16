import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

import Player;
import Save;

class Lives extends Entity {

	public function new () {
		baseSprite = new Image("graphics/" + Save.load().ship);
		sprite = [
			baseSprite,
			new Image("graphics/playerShip" + (Save.load().ship_type + 1) + "_damage1.png"),
			new Image("graphics/playerShip" + (Save.load().ship_type + 1) + "_damage2.png"),
			new Image("graphics/playerShip" + (Save.load().ship_type + 1) + "_damage3.png")
		];
		
		maxDamage = Save.load().ship_type + Save.load().ship_color;

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
		layer = -4;

	}

	public inline function addDamage() {damage++;}
	public inline function remDamage() {if (damage != 0) damage--;}

	public override function update() {
		graphic = baseSprite;
		this.addGraphic(sprite[Math.floor((damage / maxDamage) * 4)]);

		liveBar.scaledWidth = (liveBar.width / maxDamage) * (maxDamage - damage);

		this.addGraphic(liveBar);

		if (damage == maxDamage) {
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
	private var maxDamage:Int;

}