import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import openfl.Assets;

class Overlay extends Entity {
    
    public function new() {
        super(HXP.halfWidth, HXP.halfHeight);

        overlay = Image.createRect(HXP.width, HXP.height, 0x000000, 0.8);
        this.centerOrigin();
        this.addGraphic(overlay);
        overlay.centerOrigin();
        this.layer = -10;

        //Init pickups
        var thingy:Image = new Image("graphics/things_gold.png");
        var star:Image = new Image("graphics/star_gold.png");
        var shield:Image = new Image("graphics/shield_gold.png");
        thingy.centerOrigin(); star.centerOrigin(); shield.centerOrigin();

        thingy.y = star.y = shield.y = -400;
        thingy.x -= 300; star.x -= 250; shield.x -= 200;
        shield.scale = thingy.scale = star.scale = 1.5;
        
        var pickupText:Text = new Text("Pick up these things for repairs,\nstars for money,\nshield for shielding from damage.");
        pickupText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
        pickupText.y = -400; pickupText.x += 90; pickupText.size = 25; pickupText.centerOrigin();

        this.addGraphic(thingy); this.addGraphic(star); this.addGraphic(shield); this.addGraphic(pickupText);


        //Init asteroids
        var meteor:Image = new Image("graphics/meteorBrown_big1.png");
        meteor.y -= 200; meteor.x -= 300; this.addGraphic(meteor);
        var meteorText:Text = new Text("Avoid these, they'll kill you."); meteorText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
        meteorText.size = 25; meteorText.centerOrigin(); this.addGraphic(meteorText); meteorText.y -= 170; meteorText.x += 70;

        //Init enemies
        var enemy:Image = new Image("graphics/enemyGreen1.png");
        enemy.x -= 300; this.addGraphic(enemy);
        var enemyText:Text = new Text("These guys 'll try to shoot you,\nshoot back."); enemyText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
        enemyText.x += 70; enemyText.y += 50; enemyText.size = 25; enemyText.centerOrigin(); this.addGraphic(enemyText);

        //Go to the store
        var dollar:Text = new Text("$", {color: 0xFFF000}); dollar.size = 100; dollar.x -= 230; dollar.centerOrigin(); dollar.y += 200;
        dollar.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
        var dollarText:Text = new Text("Make money to buy stuff at the\nstore (It'll make the game easier).");
        dollarText.size = 25; dollarText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName; dollarText.x += 130;
        dollarText.centerOrigin();
        dollarText.y += 210;

        this.addGraphic(dollar); this.addGraphic(dollarText);

        //Ok button
        var buttonText:Text = new Text("Ok", {color: 0x000000});
        buttonText.size = 40; buttonText.font = Assets.getFont("font/kenpixel_mini_square.ttf").fontName;
        buttonText.centerOrigin();

        button = new Image("graphics/buttonGreen.png");
        button.scale = 2; button.centerOrigin();

        button.y = buttonText.y = HXP.halfHeight - 200;

        this.addGraphic(button); this.addGraphic(buttonText);

    }

    public override function update() {
        super.update();

        if (Input.mousePressed) {
            if (Input.mouseY > HXP.halfHeight - 250) {
                Save.save("overlay", false);
                this.scene.remove(this);
            }
        }
    }

    private var overlay:Image;
    private var button:Image;

}