package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var mainHud:MainHud;
	var shopData:ShopData;
	
	override public function create()
	{
		var background = new FlxSprite();
		background.loadGraphic(AssetPaths.bliss__png);

		background.scale.set(1.01, 1.01);
/*
 		var catBackground = new FlxBackdrop(AssetPaths.background__png);
		catBackground.alpha = 0.25;
		catBackground.scale.set(2, 2);
		catBackground.velocity.set(25,25);
		*/
		
		add(background);
		//add(catBackground);

		var catClicker = new CatClicker();
		add(catClicker);

		var shopData = new ShopData();
        add(shopData);

		var mainHud = new MainHud();
		add(mainHud);
		
		FlxG.cameras.bgColor = 0xffffffff;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}