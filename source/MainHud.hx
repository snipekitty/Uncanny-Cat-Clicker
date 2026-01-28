package;

import ShopData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class MainHud extends FlxTypedGroup<FlxSprite>
{
    // hud for the the milk counter
    static var milkText:FlxText;
    public static var milkNum:Float = 0;

    public static var clickBonus:Float = 0;
    public static var clicksPerSecond:Float = 0;
    public static var cpsOld:Float = 0;
    public static var cpsText:FlxText;

    public static var shopIcon:FlxSprite;
    static var shopIconScale:Float = 0.2;
    public static var shopBackground:FlxSprite;
    public static var isShopOpened:Bool = false;

    // 1ish second timer to delay how fast clickspersecond goes
    static var autoClickDelay:Float = 0;

    public function new() 
    {
        super();
        milkText = new FlxText(0, 0, "0 Milk", 60);
        milkText.screenCenter(X);
        milkText.font = "assets/fonts/Comic Sans MS.ttf";
        milkText.borderStyle = OUTLINE;
        milkText.borderColor = FlxColor.BLACK;
        milkText.borderSize = 2;
        milkText.antialiasing = true;

        cpsText = new FlxText(0, milkText.width - 110, "Milk Per Second: 0", 30);
        cpsText.font = "assets/fonts/Comic Sans MS.ttf";
        cpsText.borderStyle = OUTLINE;
        cpsText.borderColor = FlxColor.BLACK;
        cpsText.borderSize = 1;
        cpsText.antialiasing = true;

        shopIcon = new FlxSprite(0, 0, AssetPaths.ShopIcon__png);
        shopIcon.scale.set(0.2, 0.2);
        shopIcon.updateHitbox();
        shopIcon.setPosition(FlxG.width - shopIcon.width - 20, 20);
        shopIcon.updateHitbox();

        shopBackground = new FlxSprite();
        shopBackground.makeGraphic(200, 720, FlxColor.GREEN);
        shopBackground.setPosition(FlxG.width - shopBackground.width);

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
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (clicksPerSecond > 0)
        {
            autoClickDelay += 1 * elapsed;
            inTheNegatives();
            if(CatClicker.canniness > 0)
            {
                milkNum = (((milkNum) + (clicksPerSecond - (CatClicker.canniness * milkNum)) * elapsed));
                cpsText.text = ("Milk Per Second: " + (FlxMath.roundDecimal(clicksPerSecond - (CatClicker.canniness * milkNum), 2)));
            } else {
                milkNum = (((milkNum) + (clicksPerSecond) * elapsed));
                cpsText.text = ("Milk Per Second: " + (clicksPerSecond));
            } 
        }
        waitBeforeCPS();
        milkText.text = (FlxMath.roundDecimal(milkNum, 0) + " Milk"); 
        shopClicked();

        milkText.screenCenter(X);
        cpsText.screenCenter(X);
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + (1 + (clickBonus)));
		trace(milkNum);
    }

    static public function waitBeforeCPS()
    {
        if(autoClickDelay >= 1) {
            autoClickDelay = 0;
        }
    }

    function shopClicked()
    {
        if(FlxG.mouse.overlaps(shopIcon))
        {
            if(FlxG.mouse.justReleased) 
            {
                isShopOpened = !isShopOpened;
                FlxTween.cancelTweensOf(shopIcon);
                //trace(isShopOpened);
            }
        }
    }
    function inTheNegatives()
    {
        if(milkNum < 0)
        {
            milkText.color = FlxColor.RED;
        } else {
            milkText.color = FlxColor.WHITE;
        }

        if((clicksPerSecond - (CatClicker.canniness * milkNum)) < 0)
        {
            cpsText.color = FlxColor.RED;
        } else {
            cpsText.color = FlxColor.WHITE;
        } 
    }
}
