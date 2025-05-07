package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var cannycat:FlxSprite;
	var cannypointstext:FlxText;
	var cannypoints:Int = 0;
	override public function create()
	{
		super.create();
		cannycat = new FlxSprite();
		cannycat.loadGraphic(AssetPaths.UncannyCat__png);
		cannycat.scale.set(0.4, 0.4);
		cannycat.updateHitbox();
		cannycat.screenCenter();
		add(cannycat);

		FlxG.cameras.bgColor = 0xff000000;

		cannypointstext = new FlxText(100, 0, " Milk", 20);
		cannypointstext.color.black;
		add(cannypointstext);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if(FlxG.mouse.overlaps(cannycat)){
			cannycat.scale.set(0.43, 0.43);
			cannycat.updateHitbox();
			if(FlxG.mouse.justReleased){
				cannypoints = Std.int((cannypoints)+1);
				updatemilktext();
			}
		} else {
				cannycat.scale.set(0.4, 0.4);
				cannycat.updateHitbox();
			};
		}
		
		function updatemilktext() {
			cannypointstext.text = ((cannypoints) + " Milk");
		}
	}