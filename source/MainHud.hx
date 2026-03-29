package;

import ShopData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedMouseSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;

class MainHud extends FlxTypedGroup<FlxSprite>
{
    // hud for the the milk counter
    static var milkText:FlxText;


    public static var cpsText:FlxText;

    public static var shopIcon:FlxSprite;
    static var shopIconScale:Float = 0.2;
    public static var shopBackground:FlxSprite;
    public static var isShopOpened:Bool = false;

    var catNewsDisplayer:FlxSprite;

    var cannyMeter:FlxBar;


    public function new() 
    {
        super();
        milkText = new FlxText(0, 20, "0 milk", 60);
        milkText.screenCenter(X);
        milkText.font = "assets/fonts/Comic Sans MS.ttf";
        milkText.borderStyle = OUTLINE;
        milkText.borderColor = FlxColor.BLACK;
        milkText.borderSize = 2;
        milkText.antialiasing = true;

        cpsText = new FlxText(0, milkText.width - 60, "milk per second: 0", 40);
        cpsText.font = "assets/fonts/Comic Sans MS.ttf";
        cpsText.borderStyle = OUTLINE;
        cpsText.borderColor = FlxColor.BLACK;
        cpsText.borderSize = 2;
        cpsText.antialiasing = true;

        shopIcon = new FlxSprite(0, 0, AssetPaths.ShopIcon__png);
        shopIcon.scale.set(0.2, 0.2);
        shopIcon.updateHitbox();
        shopIcon.setPosition(FlxG.width - shopIcon.width - 40, 20);
        shopIcon.updateHitbox();

        shopBackground = new FlxSprite();
        shopBackground.loadGraphic(AssetPaths.shopBackground__png);
        shopBackground.setPosition(FlxG.width - shopBackground.width);

        catNewsDisplayer = new FlxSprite();
        catNewsDisplayer.loadGraphic(AssetPaths.newstv__png);
        catNewsDisplayer.setPosition(0, FlxG.height - catNewsDisplayer.height);

        cannyMeter = new FlxBar(0, 0, BOTTOM_TO_TOP, 10, 70, 0, "Canniness", -0.5, 1, true);
        cannyMeter.createFilledBar(FlxColor.WHITE, FlxColor.BLACK, false);
        cannyMeter.scale.set(5, 5);
        cannyMeter.updateHitbox();
        cannyMeter.setPosition(0, 0);
        cannyMeter.screenCenter(Y);
        cannyMeter.y = cannyMeter.y - 20;
        add(cannyMeter);

        var shopArray = ShopData.shopArray;
        var shopDescriptions = ShopData.shopDescriptions;

        add(shopBackground);

        for (shops in 0...shopArray.length)
		{
            add(shopArray[shops]);
		    shopArray[shops].kill();
            shopArray[shops].updateHitbox();

            add(shopDescriptions[shops]);
            shopDescriptions[shops].color = FlxColor.BLACK;
            shopDescriptions[shops].kill();
		}        
        add(shopIcon);
        add(milkText);
        add(cpsText);
        add(catNewsDisplayer);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (Values.clicksPerSecond > 0)
        {
            inTheNegatives();

        }
        milkText.text = (FlxMath.roundDecimal(Values.milkNum, 0) + " milk"); 
        shopClicked();

        milkText.screenCenter(X);
        cpsText.screenCenter(X);

        cannyMeter.value = CatClicker.canniness;

    }



    function shopClicked()
    {
        if(FlxG.mouse.overlaps(shopIcon))
        {
            if(FlxG.mouse.justReleased) 
            {
                isShopOpened = !isShopOpened;
                FlxTween.cancelTweensOf(shopIcon);
            }
        }
    }

    function inTheNegatives()
    {
        if(Values.milkNum < 0)
        {
            milkText.color = FlxColor.RED;
        } else {
            milkText.color = FlxColor.WHITE;
        }

        if((Values.clicksPerSecond / (1 + CatClicker.canniness)) <= Values.clicksPerSecond)
        {
            cpsText.color = FlxColor.RED;
        } else {
            cpsText.color = FlxColor.WHITE;
        } 
    }
}
