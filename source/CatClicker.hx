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

        var cannySounds:Array<FlxSound> = [];
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
                FlxTween.cancelTweensOf(this);
                MainHud.updateMilkText();
                FlxTween.tween(this, { "scale.x": 0.4, "scale.y": 0.4}, 0.5, { ease: FlxEase.elasticOut });
            }
        } else {
            FlxTween.tween(this, { "scale.x": 0.5, "scale.y": 0.5}, 0.1, { ease: FlxEase.elasticOut });
        }
    }
}