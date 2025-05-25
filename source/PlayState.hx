package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var milkHud:MilkHud;
	override public function create()
	{
		var backgroundImage = new FlxSprite();
		backgroundImage.loadGraphic(AssetPaths.background__png);
		add(backgroundImage);
		
		var catClicker = new CatClicker();
		add(catClicker);

		var milkHud = new MilkHud();
		add(milkHud);

		FlxG.cameras.bgColor = 0xffffffff;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}