package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var mainHud:MainHud;
	var shopData:ShopData;
	var catTreat:CatTreat;
	var newsTicker:NewsTicker;
	var values:Values;

	var nighttime:Bool = false;

	var debugText:FlxText;
	
	override public function create()
	{
		persistentUpdate = true;

		debugText = new FlxText(100, 100, 0, "hello", 16);

		var background = new FlxSprite();
		background.loadGraphic(AssetPaths.bliss__png);

		background.scale.set(3, 3);
		background.y = background.y + 50;
		
		var values = new Values();
		add(values);

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

		add(debugText);
		
		FlxG.cameras.bgColor = 0xff000000;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		debugText.text = "hunger: " + (CatClicker.hunger) + " sleep: " + (CatClicker.sleepiness) + " dirty: " + (CatClicker.dirtiness);
	}
}