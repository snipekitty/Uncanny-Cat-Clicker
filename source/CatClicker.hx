package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class CatClicker extends FlxTypedGroup<FlxSprite>
{   
    public static var cannyCat:FlxSprite;

    var cannyHeh = FlxG.sound.load(AssetPaths.heh__wav);
	var cannyNah = FlxG.sound.load(AssetPaths.nah__wav);
	var cannyNyeh = FlxG.sound.load(AssetPaths.nyeh__wav);

    var cannySounds:Array<FlxSound>;

    var clickText:FlxText;
    var clickTextTimer:FlxTimer;

    var defaultScale:Float = 0.8;

    public function new() 
    {
        super();

        cannyCat = new FlxSprite();
        cannyCat.loadGraphic(AssetPaths.CannyCat__png);
        cannyCat.scale.set(0.8, 0.8);
        cannyCat.updateHitbox();
        cannyCat.screenCenter();

        add(cannyCat);
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        clicking();
    }

    function clicking() 
    {
        if(FlxG.mouse.overlaps(cannyCat))
        {
            FlxTween.tween(cannyCat, { "scale.x": defaultScale + 0.05, "scale.y": defaultScale + 0.05}, 0.1, { ease: FlxEase.linear });
            if(FlxG.mouse.justReleased) 
            {
                playCannySounds();
                FlxTween.cancelTweensOf(cannyCat);
                MainHud.updateMilkText();
                FlxTween.tween(cannyCat, { "scale.x": defaultScale - 0.3, "scale.y": defaultScale - 0.3}, 0.5, { ease: FlxEase.linear });
            }
        } else {
            FlxTween.cancelTweensOf(cannyCat);
            FlxTween.tween(cannyCat, { "scale.x": defaultScale, "scale.y": defaultScale}, 0.1, { ease: FlxEase.linear });
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