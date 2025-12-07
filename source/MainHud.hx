package;

import ShopData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import openfl.display.FPS;

class MainHud extends FlxTypedGroup<FlxSprite>
{
    // hud for the the milk counter
    static var milkText:FlxText;
    public static var milkNum:Float = 0;
    // todo: work on shop

    static var clickBonus:Float = 0;
    public static var clicksPerSecond:Float = 0;
    public static var cpsText:FlxText;

    // shop, names are pretty self explanatory
    var shopIcon:FlxSprite;
    public static var isShopOpened:Bool = false;

    // 1ish second timer to delay how fast clickspersecond goes
    static var autoClickDelay:Float = 0;

    public function new() 
    {
        super();
        milkText = new FlxText(100, 0, "0 Milk", 30);
        milkText.font = "assets/fonts/Comic Sans MS.ttf";

        cpsText = new FlxText(100, 32, "Milk Per Second: 0", 20);
        cpsText.font = "assets/fonts/Comic Sans MS.ttf";

        shopIcon = new FlxSprite(550, 20, AssetPaths.ShopIcon__png);
        shopIcon.scale.set(0.1, 0.1);
        shopIcon.updateHitbox();

        add(shopIcon);
        add(milkText);
        add(cpsText);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        // autoclickdelay counts up here
        autoClickDelay += 1 * elapsed;
        waitBeforeCPS();
        milkText.text = ((milkNum) + " Milk");
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
            milkNum = ((milkNum) + (clicksPerSecond));
        }
    }

    function shopClicked()
    // shop icon hover animation and doing of things
    {
        if(FlxG.mouse.overlaps(shopIcon))
        {
            FlxTween.tween(shopIcon, { "scale.x": 0.12, "scale.y": 0.12}, 0.1, { ease: FlxEase.elasticOut });
            if(FlxG.mouse.justReleased) 
            {
                shopOpened();
                ShopData.showShopOpened();
                FlxTween.cancelTweensOf(shopIcon);
                FlxTween.tween(shopIcon, { "scale.x": 0.09, "scale.y": 0.09}, 0.5, { ease: FlxEase.elasticOut });
                trace(isShopOpened);
            }
        } else {
            FlxTween.tween(shopIcon, { "scale.x": 0.1, "scale.y": 0.1}, 0.1, { ease: FlxEase.elasticOut });
        }
    }

    function shopOpened() 
    {
        isShopOpened = !isShopOpened;            
    }
}
