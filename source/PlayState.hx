package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var mainHud:MainHud;
	var shopData:ShopData;
	
	override public function create()
	{
		var background = new FlxSprite();
		background.loadGraphic(AssetPaths.bliss__png);
		//removes white line, trust me this is needed
		background.scale.set(1.01, 1.01);

 		var catBackground = new FlxBackdrop(AssetPaths.background__png);
		catBackground.alpha = 0.5;
		catBackground.velocity.set(25,25);
		
		add(background);
		add(catBackground);

		var catClicker = new CatClicker();
		add(catClicker);

		var mainHud = new MainHud();
		add(mainHud);

		var shopData = new ShopData();
        add(shopData);

		FlxG.cameras.bgColor = 0xffffffff;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}