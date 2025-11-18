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

    static var shopArray:Array<FlxSprite>;

    public function new() 
    {
        super();

        extraClickTest = new FlxSprite();
        extraClickTest.makeGraphic(150, 100, FlxColor.WHITE);
        extraClickTest.setPosition(FlxG.width - extraClickTest.width, 100);

        add(extraClickTest);

        extraShopItemTest = new FlxSprite();
        extraShopItemTest.makeGraphic(150, 100, FlxColor.WHITE);
        extraShopItemTest.setPosition(FlxG.width - extraShopItemTest.width, extraClickTest.y + 100);

        shopArray = [extraClickTest, extraShopItemTest];

        shopArray[0].kill();

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
            shopArray[0].revive();
        }
        else
        {
            shopArray[0].kill();
        }
    }
}