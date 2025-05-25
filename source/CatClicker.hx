package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import MilkHud;

class CatClicker extends FlxSprite
{
    public function new() {
        super();
        loadGraphic(AssetPaths.CannyCat__png);
        scale.set(0.6, 0.6);
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
                MilkHud.updateMilkText();
            }
        }
    }
}
