package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;

class MilkHud extends FlxTypedGroup<FlxSprite>
{
    var milkText:FlxText;
    var milkNum:Int = 0;

    public function new() 
    {
        super();
        milkText = new FlxText(100, 0, "0 Milk", 20);
        add(milkText);
    }

    public function updateMilkText() 
    {
        milkNum = Std.int((milkNum) + 1);
        milkText.text = ((milkText) + " Milk");
    }
}
