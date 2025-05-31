package;

import flixel.FlxG;
import flixel.FlxSprite;

class CatTreats extends FlxSprite
{
    public function new() {
        super();
        loadGraphic(AssetPaths.CatTreat__png);
        scale.set(0.25, 0.25);
        updateHitbox();
        visible = false;
    } //visibility test isnt working i hate my life... truthfully it should work tho
}