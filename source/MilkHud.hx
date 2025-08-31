package;

import lime.utils.Float64Array;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;

class MilkHud extends FlxTypedGroup<FlxSprite>
{
    // hud for the the milk counter
    static var milkText:FlxText;
    static var milkNum:Float = 0;

    public function new() 
    {
        super();
        milkText = new FlxText(100, 0, "0 Milk", 30);
        milkText.font = "assets/fonts/Comic Sans MS.ttf";
        add(milkText);
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + 1);
        milkText.text = ((milkNum) + " Milk");
    }
}
