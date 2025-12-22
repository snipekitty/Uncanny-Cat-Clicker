package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class CatClicker extends FlxSprite
{    
    var cannyHeh = FlxG.sound.load(AssetPaths.heh__wav);
	var cannyNah = FlxG.sound.load(AssetPaths.nah__wav);
	var cannyNyeh = FlxG.sound.load(AssetPaths.nyeh__wav);

    var cannySounds:Array<FlxSound>;

    var defaultScale:Float = 0.8;

    public function new() 
    {
        super();
        loadGraphic(AssetPaths.CannyCat__png);
        scale.set(0.8, 0.8);
        updateHitbox();
        screenCenter();
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
        clicking();
    }

    function clicking() 
    {
        if(FlxG.mouse.overlaps(this))
        {
            FlxTween.tween(this, { "scale.x": defaultScale + 0.05, "scale.y": defaultScale + 0.05}, 0.1, { ease: FlxEase.linear });
            if(FlxG.mouse.justReleased) 
            {
                playCannySounds();
                FlxTween.cancelTweensOf(this);
                MainHud.updateMilkText();
                FlxTween.tween(this, { "scale.x": defaultScale - 0.3, "scale.y": defaultScale - 0.3}, 0.5, { ease: FlxEase.linear });
            }
        } else {
            FlxTween.cancelTweensOf(this);
            FlxTween.tween(this, { "scale.x": defaultScale, "scale.y": defaultScale}, 0.1, { ease: FlxEase.linear });
        }
    }

    function playCannySounds()
    {
        cannySounds = [cannyHeh, cannyNah, cannyNyeh];

        var randomNumber = FlxG.random.int(0, 2);

		cannySounds[randomNumber].play(true);
		//trace(cannySounds);
		//trace(randomNumber);
    }
}