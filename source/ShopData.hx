package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ShopData extends FlxTypedGroup<FlxSprite>
{
    static var extraClickTest:FlxSprite;
    static var extraShopItemTest:FlxSprite;

    static var shopArray:Array<FlxSprite>;
    static var shopPrices:Array<Float>;
    static var shopDescriptions:Array<FlxText>;

    public function new() 
    {
        super();

        extraClickTest = new FlxSprite();
        extraClickTest.makeGraphic(150, 100, FlxColor.WHITE);
        extraClickTest.setPosition(FlxG.width - extraClickTest.width, 100);

        extraShopItemTest = new FlxSprite();
        extraShopItemTest.makeGraphic(150, 100, FlxColor.WHITE);
		extraShopItemTest.setPosition(FlxG.width - extraShopItemTest.width, extraClickTest.y + 110);

        shopArray = [extraClickTest, extraShopItemTest];

        shopPrices = [10, 100];

        shopDescriptions = [new FlxText(extraClickTest.x, extraClickTest.y, 0, "I love you! <3", 20), new FlxText(extraShopItemTest.x, extraShopItemTest.y, 0, "I hate you. </3", 20)];

        for (descriptions in 0...shopDescriptions.length)
        {
            for (shops in 0...shopArray.length)
		    {
                add(shopArray[shops]);
			    shopArray[shops].kill();

                add(shopDescriptions[shops]);
                shopDescriptions[shops].color = FlxColor.BLACK;
                shopDescriptions[shops].kill();
		    }
        }
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        shopItemIsClicked();
        buyableState();

        for (descriptions in 0...shopDescriptions.length)
        {
            shopDescriptions[descriptions].scale.x = shopArray[descriptions].scale.x;
            shopDescriptions[descriptions].scale.y = shopArray[descriptions].scale.y;
        }
    }

    static public function showShopOpened() 
    {
        for (shops in 0...shopArray.length)
        {
            if(MainHud.isShopOpened == true)
            {
			    shopArray[shops].revive();
                shopDescriptions[shops].revive();
		    }
            else
            {
		        shopArray[shops].kill();
                shopDescriptions[shops].kill();
		    }
        }
    }
    function shopItemIsClicked()
    {
        if(shopArray[0].alive == true)
        {
            clickAnim();
            if(MainHud.milkNum >= shopPrices[0])
            {
                if(FlxG.mouse.overlaps(shopArray[0]))
                {
                    if(FlxG.mouse.justReleased)
                    {
                        MainHud.milkNum = MainHud.milkNum - shopPrices[0];
                        MainHud.clicksPerSecond = MainHud.clicksPerSecond + 10; 
                    }
                }   
            }

            if(MainHud.milkNum >= shopPrices[1])
            {
                if(FlxG.mouse.overlaps(shopArray[1]))
                {
                    if(FlxG.mouse.justReleased)
                    {
                        MainHud.milkNum = MainHud.milkNum - shopPrices[1]; 
                    }
                }   
            }
        }
    }

    function buyableState()
    {
        for (check in 0...shopPrices.length)
        {
            // this could be a switch i think?
            if(MainHud.milkNum < shopPrices[check])
            {
                shopArray[check].alpha = 0.5;
            } else if(MainHud.milkNum >= shopPrices[check]) {
                shopArray[check].alpha = 1;
            }
        }
    }

    function clickAnim() 
    {
        for (shops in 0...shopArray.length)
        {
            if(FlxG.mouse.overlaps(shopArray[shops]))
            {
                FlxTween.tween(shopArray[shops], { "scale.x": 0.9, "scale.y": 0.9}, 0.1, { ease: FlxEase.elasticOut });
                if(FlxG.mouse.justReleased) 
                {
                    FlxTween.cancelTweensOf(shopArray[shops]);
                    FlxTween.tween(shopArray[shops], { "scale.x": 0.8, "scale.y": 0.8}, 0.5, { ease: FlxEase.elasticOut });
                }
            } else {
                FlxTween.tween(shopArray[shops], { "scale.x": 1, "scale.y": 1}, 0.1, { ease: FlxEase.elasticOut });
            }
        }
    }
}