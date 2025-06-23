package;

import flixel.FlxG;
import flixel.FlxSprite;

class CatTreats extends FlxSprite
{
    public function new() {
        super();
        loadGraphic(AssetPaths.CatTreat__png);
        scale.set(0.25, 0.25);
        visible = false;
        updateHitbox();
    } // if it's not visible it doesnt do anythingi think especially if i update the hitbox after visibility false
}