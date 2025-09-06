package;

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
    static var shopIcon:FlxSprite;

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
        shopClicked();
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + 1);
        milkText.text = ((milkNum) + " Milk");
        trace(milkNum);
    }

    function shopClicked()
    {
        if(FlxG.mouse.overlaps(shopIcon))
        {
            FlxTween.tween(shopIcon, { "scale.x": 0.13, "scale.y": 0.13}, 0.1, { ease: FlxEase.elasticOut });
            if(FlxG.mouse.justReleased) 
            {
                FlxTween.cancelTweensOf(shopIcon);
                FlxTween.tween(shopIcon, { "scale.x": 0.08, "scale.y": 0.08}, 0.5, { ease: FlxEase.elasticOut });
            }
        } else {
            FlxTween.tween(shopIcon, { "scale.x": 0.1, "scale.y": 0.1}, 0.1, { ease: FlxEase.elasticOut });
        }
    }
}
