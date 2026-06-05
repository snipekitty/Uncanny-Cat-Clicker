package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedMouseSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;

class CareItems extends FlxTypedGroup<FlxSprite>
{
    var catFood:FlxExtendedMouseSprite;
    var catSleep:FlxExtendedMouseSprite;
    var catSponge:FlxExtendedMouseSprite;

    var itemsGroup:Array<FlxSprite>;
    var defaultPositions:Array<FlxPoint>;

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

        itemsGroup = [catFood, catSleep, catSponge];
        defaultPositions = [FlxPoint.weak(354, 170), FlxPoint.weak(330, 425), FlxPoint.weak(346, 312)];

        for(items in 0...itemsGroup.length)
        {
            add(itemsGroup[items]);
        }

        
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        defaultPos();
    }

    function defaultPos()
    {
        for(items in 0...itemsGroup.length)
        {
            if(itemsGroup[items].getPosition() == defaultPositions[items])
            {
                trace("they are in correct positions");
            } else {
                trace("they are not");
            }
        }
    }
}