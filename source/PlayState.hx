package;

import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.chainable.FlxWaveEffect;

class PlayState extends FlxState
{
	var catClicker:CatClicker;
	var mainHud:MainHud;

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