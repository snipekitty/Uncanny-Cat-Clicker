package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var mainHud:MainHud;
	var shopData:ShopData;
	var catTreat:CatTreat;
	var newsTicker:NewsTicker;
	
	override public function create()
	{
		persistentUpdate = true;

		var background = new FlxSprite();
		background.loadGraphic(AssetPaths.bliss__png);

		background.scale.set(3, 3);
		background.y = background.y + 50;
		
		add(background);

		var catClicker = new CatClicker();
		add(catClicker);

		var shopData = new ShopData();
        add(shopData);

		var newsTicker = new NewsTicker();
		add(newsTicker);

		var mainHud = new MainHud();
		add(mainHud);

		var catTreat = new CatTreat();
		add(catTreat);
		
		FlxG.cameras.bgColor = 0xffffffff;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}