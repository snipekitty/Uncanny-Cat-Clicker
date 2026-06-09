package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedMouseSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.input.FlxPointer;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class CareItems extends FlxTypedGroup<FlxSprite>
{
    var catFood:FlxExtendedMouseSprite;
    var catSleep:FlxExtendedMouseSprite;
    var catSponge:FlxExtendedMouseSprite;

    var itemsGroup:Array<FlxSprite>;
    var defaultPositions:Array<String>;

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
        defaultPositions = ["(x: 354 | y: 170)", "(x: 330 | y: 425)", "(x: 346 | y: 312)"];

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
            if(Std.string(itemsGroup[items].getPosition()) == defaultPositions[items])
            {

            } else {
                if(FlxG.mouse.pressed == false)
                {
                    itemsGroup[0].setPosition(FlxMath.lerp(itemsGroup[0].x, 354, 0.1), FlxMath.lerp(itemsGroup[0].y, 170, 1 - Math.pow(0.01, FlxG.elapsed)));
                    itemsGroup[1].setPosition(FlxMath.lerp(itemsGroup[1].x, 330, 0.1), FlxMath.lerp(itemsGroup[1].y, 425, 1 - Math.pow(0.01, FlxG.elapsed)));
                    itemsGroup[2].setPosition(FlxMath.lerp(itemsGroup[2].x, 346, 0.1), FlxMath.lerp(itemsGroup[2].y, 312, 1 - Math.pow(0.01, FlxG.elapsed)));
                }
            }
        }
    }
}