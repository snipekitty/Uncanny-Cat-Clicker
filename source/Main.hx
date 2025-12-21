package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState, 60, 60, true));
		addChild(new FPS(10, 10, 0x000000));
		FlxG.autoPause = false;
		FlxG.mouse.useSystemCursor = true;
	}
}
