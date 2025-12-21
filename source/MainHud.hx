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

    static var clickBonus:Float = 0;
    public static var clicksPerSecond:Float = 0;
    public static var cpsText:FlxText;

    public static var shopIcon:FlxSprite;
    public static var shopBackground:FlxSprite;
    public static var isShopOpened:Bool = false;

    // 1ish second timer to delay how fast clickspersecond goes
    static var autoClickDelay:Float = 0;

    public function new() 
    {
        super();
        milkText = new FlxText(100, 0, "0 Milk", 30);
        milkText.font = "assets/fonts/Comic Sans MS.ttf";
        milkText.borderStyle = OUTLINE;
        milkText.borderColor = FlxColor.BLACK;
        milkText.borderSize = 1;

        cpsText = new FlxText(100, 32, "Milk Per Second: 0", 20);
        cpsText.font = "assets/fonts/Comic Sans MS.ttf";


        shopIcon = new FlxSprite(550, 20, AssetPaths.ShopIcon__png);
        shopIcon.scale.set(0.1, 0.1);
        shopIcon.updateHitbox();

        shopBackground = new FlxSprite();
        shopBackground.makeGraphic(160, 480, FlxColor.GREEN);
        shopBackground.setPosition(FlxG.width - shopBackground.width);

        var shopArray = ShopData.shopArray;
        var shopDescriptions = ShopData.shopDescriptions;

        add(shopBackground);
        shopBackground.kill();

        for (shops in 0...shopArray.length)
		{
            add(shopArray[shops]);
		    shopArray[shops].kill();

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
            milkNum = (((milkNum) + (clicksPerSecond) * elapsed));
        }
        waitBeforeCPS();
        milkText.text = (FlxMath.roundDecimal(milkNum, 0) + " Milk");
        cpsText.text = ("Milk Per Second: " + (clicksPerSecond));
        shopClicked();
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + (1 + (clickBonus)));
		//trace(milkNum);
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
            FlxTween.tween(shopIcon, { "scale.x": 0.12, "scale.y": 0.12}, 0.1, { ease: FlxEase.elasticOut });
            if(FlxG.mouse.justReleased) 
            {
                isShopOpened = !isShopOpened;
                ShopData.shopOpened();
                FlxTween.cancelTweensOf(shopIcon);
                FlxTween.tween(shopIcon, { "scale.x": 0.09, "scale.y": 0.09}, 0.5, { ease: FlxEase.elasticOut });
                //trace(isShopOpened);
            }
        } else {
            FlxTween.tween(shopIcon, { "scale.x": 0.1, "scale.y": 0.1}, 0.1, { ease: FlxEase.elasticOut });
        }
    }
}
