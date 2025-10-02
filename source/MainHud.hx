package;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxSprite;

class MainHud extends FlxTypedGroup<FlxSprite>
{
    // hud for the the milk counter
    static var milkText:FlxText;
    static var milkNum:Float = 0;
    static var clickBonus:Float = 0;
    static var clicksPerSecond:Float = 1;
    var shopIcon:FlxSprite;
    var isShopOpened:Bool = false;
    static var autoClickDelay:Float = 0;

    public function new() 
    {
        super();
        milkText = new FlxText(100, 0, "0 Milk", 30);
        milkText.font = "assets/fonts/Comic Sans MS.ttf";

        shopIcon = new FlxSprite(550, 20, AssetPaths.ShopIcon__png);
        shopIcon.scale.set(0.1, 0.1);
        shopIcon.updateHitbox();

        add(shopIcon);
        add(milkText);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        autoClickDelay += 1;
        waitBeforeCPS();
        milkText.text = ((milkNum) + " Milk");
        shopClicked();
        shopOpened();
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + (1 + (clickBonus)));
        trace(milkNum);
    }

    static public function waitBeforeCPS()
    {
        if(autoClickDelay == 100) {
            autoClickDelay = 0;
            milkNum = ((milkNum) + (clicksPerSecond));
        }
    }

    function shopClicked()
    {
        if(FlxG.mouse.overlaps(shopIcon))
        {
            FlxTween.tween(shopIcon, { "scale.x": 0.12, "scale.y": 0.1}, 0.1, { ease: FlxEase.elasticOut });
            if(FlxG.mouse.justReleased) 
            {
                isShopOpened = !isShopOpened;
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
        if(isShopOpened)
        {
            isShopOpened = !isShopOpened;
            
            trace(isShopOpened);
        }
    }
}
