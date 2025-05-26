package;

import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.effects.chainable.FlxWaveEffect;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var milkHud:MilkHud;
	override public function create()
	{
		var backgroundImage = new FlxSprite();
		backgroundImage.loadGraphic(AssetPaths.background__png);
		var waveEffect = new FlxWaveEffect(FlxWaveMode.ALL, 10, -1, 4);
		var waveBackground = new FlxEffectSprite(backgroundImage, [waveEffect]);
		add(waveBackground);
		add(backgroundImage);
		
		var catClicker = new CatClicker();
		add(catClicker);

		var milkHud = new MilkHud();
		add(milkHud);

		FlxG.cameras.bgColor = 0xff000000;

		super.create();

		
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}