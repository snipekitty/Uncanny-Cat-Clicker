package;

import flixel.FlxBasic;
import flixel.math.FlxMath;

class Values extends FlxBasic
{
    public static var milkNum:Float = 0;
    public static var clicksPerSecond:Float = 0;
    public static var clickBonus:Float = 0;
    public static var cpsOld:Float = 0;

    public function new()
    {
        super();
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        if(CatClicker.canniness > 0)
        {
            milkNum = (((milkNum) + (clicksPerSecond / (1 + CatClicker.canniness)) * elapsed));
            MainHud.cpsText.text = ("milk per second: " + (FlxMath.roundDecimal(Values.clicksPerSecond / (1 + CatClicker.canniness), 2)));
        } else {
            milkNum = (((milkNum) + (clicksPerSecond) * elapsed));
            MainHud.cpsText.text = ("milk per second: " + (clicksPerSecond));
        } 
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + (1 + (clickBonus)));
		trace(milkNum);
    }
}