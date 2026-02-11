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
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

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

    var catNewsDisplayer:FlxSprite;
    var catFood:FlxExtendedMouseSprite;
    var catFoodCopy:FlxSprite;

    var sponge:FlxExtendedMouseSprite;
    var spongeCopy:FlxSprite;

    var sleepIcon:FlxExtendedMouseSprite;
    var sleepCopy:FlxSprite;

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

        catFood = new FlxExtendedMouseSprite(354, 170);
        catFood.loadGraphic(AssetPaths.CatFood__png);
        catFood.scale.set(0.2, 0.2);
        catFood.updateHitbox();
        catFood.draggable = true;

        catFoodCopy = catFood.clone();
        catFoodCopy.scale.set(0.2, 0.2);
        catFoodCopy.setPosition(354, 170);
        catFoodCopy.updateHitbox();

        sponge = new FlxExtendedMouseSprite(346, 312);
        sponge.loadGraphic(AssetPaths.sponge__png);
        sponge.scale.set(0.4, 0.4);
        sponge.updateHitbox();
        sponge.draggable = true;

        spongeCopy = sponge.clone();
        spongeCopy.scale.set(0.4, 0.4);
        spongeCopy.setPosition(346, 312);
        spongeCopy.updateHitbox();

        sleepIcon = new FlxExtendedMouseSprite(330, 425);
        sleepIcon.loadGraphic(AssetPaths.sleepIcon__png);
        sleepIcon.scale.set(0.2, 0.2);
        sleepIcon.updateHitbox();
        sleepIcon.draggable = true;

        sleepCopy = sleepIcon.clone();
        sleepCopy.scale.set(0.2, 0.2);
        sleepCopy.setPosition(330, 425);
        sleepCopy.updateHitbox();

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
        add(catFoodCopy);
        add(spongeCopy);
        add(sleepCopy);
        add(sleepIcon);
        add(sponge);
        add(catFood);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if (clicksPerSecond > 0)
        {
            inTheNegatives();
            if(CatClicker.canniness > 0)
            {
                milkNum = (((milkNum) + (clicksPerSecond / (1 + CatClicker.canniness)) * elapsed));
                cpsText.text = ("milk per second: " + (FlxMath.roundDecimal(clicksPerSecond / (1 + CatClicker.canniness), 2)));
            } else {
                milkNum = (((milkNum) + (clicksPerSecond) * elapsed));
                cpsText.text = ("milk per second: " + (clicksPerSecond));
            } 
        }
        milkText.text = (FlxMath.roundDecimal(milkNum, 0) + " milk"); 
        shopClicked();

        catFoodDragged();
        milkText.screenCenter(X);
        cpsText.screenCenter(X);
    }

    static public function updateMilkText() 
    {
        milkNum = ((milkNum) + (1 + (clickBonus)));
		trace(milkNum);
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

    function catFoodDragged()
    {
        if(catFood.isDragged == false && catFood.overlaps(CatClicker.cannyCat) == false)
        {
            FlxTween.cancelTweensOf(catFood);
            FlxTween.tween(catFood, { x: 354, y: 170 }, 0.5, {ease: FlxEase.elasticOut});
        } else if(catFood.isDragged == false && catFood.overlaps(CatClicker.cannyCat) == true)
        {
            catFood.x = catFoodCopy.x;
            catFood.y = catFoodCopy.y;
        }
        if(sponge.isDragged == false && sponge.overlaps(CatClicker.cannyCat) == false)
        {
            FlxTween.cancelTweensOf(sponge);
            FlxTween.tween(sponge, { x: 346, y: 312 }, 0.5, {ease: FlxEase.elasticOut});
        } else if(sponge.isDragged == false && sponge.overlaps(CatClicker.cannyCat) == true)
        {
            sponge.x = spongeCopy.x;
            sponge.y = spongeCopy.y;
        }
        if(sleepIcon.isDragged == false && sleepIcon.overlaps(CatClicker.cannyCat) == false)
        {
            FlxTween.cancelTweensOf(sleepIcon);
            FlxTween.tween(sleepIcon, { x: 330, y: 425 }, 0.5, {ease: FlxEase.elasticOut});
        } else if(sleepIcon.isDragged == false && sleepIcon.overlaps(CatClicker.cannyCat) == true)
        {
            sleepIcon.x = sleepCopy.x;
            sleepIcon.y = sleepCopy.y;
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

        if((clicksPerSecond / (1 + CatClicker.canniness)) <= clicksPerSecond)
        {
            cpsText.color = FlxColor.RED;
        } else {
            cpsText.color = FlxColor.WHITE;
        } 
    }
}
