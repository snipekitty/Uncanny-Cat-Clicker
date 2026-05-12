package;

import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedMouseSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;

class TakecareItems extends FlxTypedGroup<FlxSprite>
{
    var catFood:FlxExtendedMouseSprite;
    var catSleep:FlxExtendedMouseSprite;
    var catSponge:FlxExtendedMouseSprite;

    var itemsGroup:FlxTypedGroup<FlxSprite>;

    public function new()
    {
        super();
        catFood = new FlxExtendedMouseSprite(354, 170);
        catFood.loadGraphic(AssetPaths.CatFood__png);
        catFood.scale.set(0.2, 0.2);
        catFood.updateHitbox();
        catFood.draggable = true;
        
        catSleep = new FlxExtendedMouseSprite(330, 425);
        catSleep.loadGraphic(AssetPaths.sleepIcon__png);
        catSleep.scale.set(0.2, 0.2);
        catSleep.updateHitbox();
        catSleep.draggable = true;

        catSponge = new FlxExtendedMouseSprite(346, 312);
        catSponge.loadGraphic(AssetPaths.sponge__png);
        catSponge.scale.set(0.4, 0.4);
        catSponge.updateHitbox();
        catSponge.draggable = true;

        itemsGroup = new FlxTypedGroup();
        itemsGroup.add(catFood);
        itemsGroup.add(catSleep);
        itemsGroup.add(catSponge);

        add(catFood);
        add(catSleep);
        add(catSponge);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}