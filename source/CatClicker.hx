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
}