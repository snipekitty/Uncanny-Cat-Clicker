package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.display.BlendMode;

class CatClicker extends FlxTypedGroup<FlxSprite>
{   
    public static var cannyCat:FlxSprite;
    var uncannyCat:FlxSprite;

    var cannyHeh = FlxG.sound.load(AssetPaths.heh__wav);
	var cannyNah = FlxG.sound.load(AssetPaths.nah__wav);
	var cannyNyeh = FlxG.sound.load(AssetPaths.nyeh__wav);

    var cannySounds:Array<FlxSound>;

    var clickText:FlxText;
    var clickTextTimer:FlxTimer;

    var defaultScale:Float = 0.8;

    var cannyMeter:FlxBar;
    public static var canniness:Float = -0.5;

    public function new() 
    {
        super();

        cannyCat = new FlxSprite();
        cannyCat.loadGraphic(AssetPaths.CannyCat__png);
        cannyCat.scale.set(0.8, 0.8);
        cannyCat.updateHitbox();
        cannyCat.screenCenter();
        //cannyCat.blend = BlendMode.MULTIPLY;
        add(cannyCat);

        uncannyCat = new FlxSprite();
        uncannyCat.loadGraphic(AssetPaths.UncannyCat__png);
        uncannyCat.scale.set(0.8, 0.8);
        uncannyCat.updateHitbox();
        uncannyCat.screenCenter();
        add(uncannyCat);

        //move to mainhud later
        cannyMeter = new FlxBar(0, 0, BOTTOM_TO_TOP, 10, 100, 0, "Canniness", -0.5, 1, true);
        cannyMeter.createFilledBar(FlxColor.WHITE, FlxColor.BLACK, false);
        cannyMeter.scale.set(5, 5);
        cannyMeter.updateHitbox();
        cannyMeter.setPosition(0, 0);
        cannyMeter.screenCenter(Y);
        add(cannyMeter);
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        clicking();

        cannyMeter.value = canniness;

        uncannyCat.scale.x = cannyCat.scale.x;
        uncannyCat.scale.y = cannyCat.scale.y;
        uncannyCat.alpha = canniness;

        //canniness += 0.1;
        trace(canniness);

        if(FlxG.keys.pressed.LEFT)
        {
            canniness -= 0.01;
            trace(canniness);
        } else if(FlxG.keys.pressed.RIGHT){
            canniness += 0.01;
            trace(canniness);
        }
        //canniness = FlxMath.roundDecimal(canniness, 3);
    }

    function clicking() 
    {
        if(FlxG.mouse.overlaps(cannyCat))
        {
            FlxTween.tween(cannyCat, { "scale.x": defaultScale + 0.05, "scale.y": defaultScale + 0.05}, 0.1, { ease: FlxEase.linear });
            if(FlxG.mouse.justReleased) 
            {
                playCannySounds();
                FlxTween.cancelTweensOf(cannyCat);
                MainHud.updateMilkText();
                FlxTween.tween(cannyCat, { "scale.x": defaultScale - 0.3, "scale.y": defaultScale - 0.3}, 0.5, { ease: FlxEase.linear });
            }
        } else {
            FlxTween.cancelTweensOf(cannyCat);
            FlxTween.tween(cannyCat, { "scale.x": defaultScale, "scale.y": defaultScale}, 0.1, { ease: FlxEase.linear });
        }
    }

    function playCannySounds()
    {
        cannySounds = [cannyHeh, cannyNah, cannyNyeh];

        var randomNumber = FlxG.random.int(0, 2);

		cannySounds[randomNumber].play(true);
		//trace(cannySounds);
		//trace(randomNumber);
    }
}