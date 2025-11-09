package;

import flixel.addons.display.shapes.FlxShapeBox;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxG;
import MainHud;

class ShopData extends FlxTypedGroup<FlxSprite>
{
    static var extraClickTest:FlxSprite;
    var extraShopItemTest:FlxSprite;

    static var shopArray:Array<FlxSprite> = [extraClickTest];

    public function new() 
    {
        super();

        var extraClickTest = new FlxSprite();
        extraClickTest.makeGraphic(150, 100, FlxColor.WHITE);
        extraClickTest.setPosition(FlxG.width - extraClickTest.width, 100);

        add(extraClickTest);

        //shopArray[0].kill();

        var uncannyShopPrices:Array<Float> = [10, 100];    
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
    }

    static public function showShopOpened() 
    {
        if(MainHud.isShopOpened == true)
        {

        }
        else
        {
            
        }
    }
}