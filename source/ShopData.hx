package;

import MainHud;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxSignal;

class ShopData extends FlxTypedGroup<FlxSprite>
{
    static var extraClickTest:FlxSprite;
    static var extraShopItemTest:FlxSprite;

    public static var shopArray:Array<FlxSprite>;
    public static var shopPrices:Array<Float>;
    public static var shopDescriptions:Array<FlxText>;
    static var shopCPSSetter:Array<Float>;

    public function new() 
    {
        super();

        extraClickTest = new FlxSprite();
        extraClickTest.makeGraphic(180, 120, FlxColor.WHITE);
        extraClickTest.setPosition(FlxG.width - extraClickTest.width, 160);
        
        extraShopItemTest = new FlxSprite();
        extraShopItemTest.makeGraphic(180, 120, FlxColor.WHITE);
		extraShopItemTest.setPosition(FlxG.width - extraShopItemTest.width, extraClickTest.y + 130);

        shopArray = [extraClickTest, extraShopItemTest];

        shopPrices = [10, 100];

        shopCPSSetter = [1, 10];

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
			    shopArray[shops].revive();
                shopDescriptions[shops].revive();
                MainHud.shopBackground.revive();
		    }
            else
            {
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
                if(MainHud.milkNum >= shopPrices[0])
                {
                    if(FlxG.mouse.overlaps(shopArray[0]))
                    {
                        if(FlxG.mouse.justReleased)
                        {
                            MainHud.milkNum = MainHud.milkNum - shopPrices[0];
                            shopPrices[0] = FlxMath.roundDecimal(shopPrices[0] * 1.15, 0);
                            shopDescriptions[0].text = "Price: " + shopPrices[0];
                            MainHud.cpsOld += shopCPSSetter[0];
                            MainHud.clicksPerSecond = MainHud.clicksPerSecond + shopCPSSetter[0];
                            switch (CatTreat.isClicked)
                            {
                                case true:
                                    MainHud.clicksPerSecond = MainHud.cpsOld * CatTreat.multNumbers[CatTreat.randomNumber];
                                case false:
                                    //do nothing
                            }
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
                            shopPrices[1] = FlxMath.roundDecimal(shopPrices[1] * 1.15, 0);
                            shopDescriptions[1].text = "Price: " + shopPrices[1];
                            MainHud.cpsOld += shopCPSSetter[0];
                            MainHud.clicksPerSecond = MainHud.clicksPerSecond + shopCPSSetter[1];
                            switch (CatTreat.isClicked)
                            {
                                case true:
                                    MainHud.clicksPerSecond = MainHud.cpsOld * CatTreat.multNumbers[CatTreat.randomNumber];
                                case false:
                                    //do nothing
                            }
                        }
                    }   
                }
            }
        }
    }

    function buyableState()
    {
        for (prices in 0...shopPrices.length)
        {
            if(MainHud.milkNum < shopPrices[prices])
            {
                shopArray[prices].alpha = 0.5;
            } else if(MainHud.milkNum >= shopPrices[prices]) {
                shopArray[prices].alpha = 1;
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