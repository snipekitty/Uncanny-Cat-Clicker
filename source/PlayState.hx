package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var cannypointstext:FlxText;
	var cannypoints:Int = 0;
	override public function create()
	{
		var catClicker = new CatClicker();
		add(catClicker);

		FlxG.cameras.bgColor = 0xff000000;

		cannypointstext = new FlxText(100, 0, " Milk", 20);
		cannypointstext.color.black;
		add(cannypointstext);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function updatemilktext()
	{
		cannypoints = Std.int((cannypoints) + 1);
		cannypointstext.text = ((cannypoints) + " Milk");
	}
}