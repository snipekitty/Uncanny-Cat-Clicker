package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ShopData extends FlxTypedGroup<FlxSprite>
{
    static var extraClickTest:FlxSprite;
    static var extraShopItemTest:FlxSprite;

    public static var shopArray:Array<FlxSprite>;
    static var shopPrices:Array<Float>;
    public static var shopDescriptions:Array<FlxText>;
    static var shopCPSSetter:Array<Float>;

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

        shopCPSSetter = [1, 10];

        // milk should probably have an icon to go along with it, thus replacing "price" with said icon
        // i dont really know how to format how the shop looks so todo i guess
        shopDescriptions = 
        [new FlxText(extraClickTest.x, extraClickTest.y, 0, "Price: " + shopPrices[0], 15), 
        new FlxText(extraShopItemTest.x, extraShopItemTest.y, 0, "Price: " + shopPrices[1], 15)];
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        shopItemIsClicked();
        buyableState();
        scrollShop();

        for (descriptions in 0...shopDescriptions.length)
        {
            shopDescriptions[descriptions].x = shopArray[descriptions].x;
            shopDescriptions[descriptions].y = shopArray[descriptions].y;

            shopDescriptions[descriptions].scale.x = shopArray[descriptions].scale.x;
            shopDescriptions[descriptions].scale.y = shopArray[descriptions].scale.y;

            shopDescriptions[descriptions].alpha = shopArray[descriptions].alpha;
        }
    }

    static public function shopOpened() 
    {
        for (shops in 0...shopArray.length)
        {
            if(MainHud.isShopOpened == true)
            {
                MainHud.shopIcon.x = MainHud.shopIcon.x;
			    shopArray[shops].revive();
                shopDescriptions[shops].revive();
                MainHud.shopBackground.revive();
		    }
            else
            {
                MainHud.shopIcon.x = MainHud.shopIcon.x;
		        shopArray[shops].kill();
                shopDescriptions[shops].kill();
                MainHud.shopBackground.kill();
		    }    
        }
    }

    function shopItemIsClicked()
    {
        if(!FlxG.mouse.overlaps(MainHud.shopIcon))
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
                            shopPrices[0] = FlxMath.roundDecimal(shopPrices[0] * 1.25, 0);
                            shopDescriptions[0].text = "Price: " + shopPrices[0];
                            MainHud.clicksPerSecond = MainHud.clicksPerSecond + shopCPSSetter[0]; 
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
                            shopPrices[1] = FlxMath.roundDecimal(shopPrices[1] * 1.25, 0);
                            shopDescriptions[1].text = "Price: " + shopPrices[1];
                            MainHud.clicksPerSecond = MainHud.clicksPerSecond + shopCPSSetter[1]; 
                        }
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

    function scrollShop() 
    {
        if (MainHud.shopBackground.alive == true)
        {
            for (shops in 0...shopArray.length)
            {
                if(FlxG.mouse.wheel > 0)
                {
                    shopArray[shops].y = shopArray[shops].y - (FlxG.mouse.wheel) - 10;
                } else if (FlxG.mouse.wheel < 0) 
                {
                    shopArray[shops].y = shopArray[shops].y - (FlxG.mouse.wheel) + 10;   
                }
            }
        }
    }
}