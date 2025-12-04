package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class ShopData extends FlxTypedGroup<FlxSprite>
{
    static var extraClickTest:FlxSprite;
    var extraShopItemTest:FlxSprite;

    static var shopArray:Array<FlxSprite>;
    static var shopPrices:Array<Float>;

    public function new() 
    {
        super();

        extraClickTest = new FlxSprite();
        extraClickTest.makeGraphic(150, 100, FlxColor.WHITE);
        extraClickTest.setPosition(FlxG.width - extraClickTest.width, 100);

        add(extraClickTest);

        extraShopItemTest = new FlxSprite();
        extraShopItemTest.makeGraphic(150, 100, FlxColor.WHITE);
		extraShopItemTest.setPosition(FlxG.width - extraShopItemTest.width, extraClickTest.y + 110);

		add(extraShopItemTest);

        shopArray = [extraClickTest, extraShopItemTest];

		for (shops in 0...shopArray.length)
		{
			shopArray[shops].kill();
		}

        shopPrices = [10, 100];    
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        shopItemIsClicked();
        buyableState();
    }

    static public function showShopOpened() 
    {
        for (shops in 0...shopArray.length)
        {
            if(MainHud.isShopOpened == true)
            {
			    shopArray[shops].revive();
		    }
            else
            {
		        shopArray[shops].kill();
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
                FlxTween.tween(shopArray[shops], { "scale.x": 0.8, "scale.y": 0.8}, 0.1, { ease: FlxEase.elasticOut });
                if(FlxG.mouse.justReleased) 
                {
                    FlxTween.cancelTweensOf(shopArray[shops]);
                    FlxTween.tween(shopArray[shops], { "scale.x": 0.4, "scale.y": 0.4}, 0.5, { ease: FlxEase.elasticOut });
                }
            } else {
                FlxTween.tween(shopArray[shops], { "scale.x": 1, "scale.y": 1}, 0.1, { ease: FlxEase.elasticOut });
            }
        }
    }
}