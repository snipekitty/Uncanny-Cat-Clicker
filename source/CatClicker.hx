package;

import flixel.sound.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import MainHud;

class CatClicker extends FlxSprite
{    
    // the cat that you can click
    public function new() {
        super();
        loadGraphic(AssetPaths.CannyCat__png);
        scale.set(0.5, 0.5);
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
            FlxTween.tween(this, { "scale.x": 0.55, "scale.y": 0.55}, 0.1, { ease: FlxEase.elasticOut });
            if(FlxG.mouse.justReleased) 
            {
                playCannySounds();
                FlxTween.cancelTweensOf(this);
                MainHud.updateMilkText();
                FlxTween.tween(this, { "scale.x": 0.4, "scale.y": 0.4}, 0.5, { ease: FlxEase.elasticOut });
            }
        } else {
            FlxTween.tween(this, { "scale.x": 0.5, "scale.y": 0.5}, 0.1, { ease: FlxEase.elasticOut });
        }
    }

    function playCannySounds()
    {
        //variable setup ( load every time sound is played, should be destroyed to load again )
        var cannyHeh = FlxG.sound.load(AssetPaths.heh__wav);
        var cannyNah = FlxG.sound.load(AssetPaths.nah__wav);
        var cannyNyeh = FlxG.sound.load(AssetPaths.nyeh__wav);
        // randomnumber should only be used here!!!!
        var randomNumber = FlxG.random.int(0, 2);

        var cannySounds:Array<FlxSound> = [cannyHeh, cannyNah, cannyNyeh];

        // actual code that needs to run
        cannySounds[randomNumber].play();
        cannySounds[randomNumber].autoDestroy;
        trace(cannySounds);
        trace(randomNumber);
    }
}