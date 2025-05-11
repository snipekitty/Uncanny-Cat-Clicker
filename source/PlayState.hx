package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var cannypointstext:FlxText;
	var catClicker = new CatClicker();
	var cannypoints:Int = 0;
	override public function create()
	{
		super.create();
		add(catClicker);

		FlxG.cameras.bgColor = 0xff000000;

		cannypointstext = new FlxText(100, 0, " Milk", 20);
		cannypointstext.color.black;
		add(cannypointstext);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(catClicker))
		{
			if (FlxG.mouse.justReleased)
			{
				updatemilktext();
			}
		}
	}

	function updatemilktext()
	{
		cannypoints = Std.int((cannypoints) + 1);
		cannypointstext.text = ((cannypoints) + " Milk");
	}
}