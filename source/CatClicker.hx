package;

import flixel.FlxG;
import flixel.FlxSprite;

class CatClicker extends FlxSprite
{

    var catClicker:FlxSprite;
    public function new() {
        super();
        loadGraphic(AssetPaths.UncannyCat__png);
        scale.set(0.4, 0.4);
        updateHitbox();
        screenCenter();
    }

    override function update(elapsed:Float) 
    {
        clicking();
        super.update(elapsed);
    }

    function clicking() 
    {
        if(FlxG.mouse.overlaps(catClicker)) {
            if(FlxG.mouse.justReleased) {
                trace("why");
            }
        }
    }
}