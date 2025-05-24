package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;

class CatClicker extends FlxSprite
{
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
        if(FlxG.mouse.overlaps(this)) 
        {
            if(FlxG.mouse.justReleased) 
            {
                
            }
        }
    }
}
