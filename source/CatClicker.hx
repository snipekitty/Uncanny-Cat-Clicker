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
import flixel.util.FlxSignal;
import flixel.util.FlxTimer;
import openfl.display.BlendMode;

class CatClicker extends FlxTypedGroup<FlxSprite>
{   
    public static var cannyCat:FlxSprite;
    var uncannyCat:FlxSprite;
    public static var catHitBox:FlxSprite;

    var cannyHeh = FlxG.sound.load(AssetPaths.heh__wav);
	var cannyNah = FlxG.sound.load(AssetPaths.nah__wav);
	var cannyNyeh = FlxG.sound.load(AssetPaths.nyeh__wav);

    var cannySounds:Array<FlxSound>;

    var clickText:FlxText;
    var clickTextTimer:FlxTimer;

    var defaultScale:Float = 0.4;

    var randomX:Float;
    var randomY:Float;

    public static var canniness:Float = -0.5;

    public function new() 
    {
        super();

        cannyCat = new FlxSprite();
        cannyCat.loadGraphic(AssetPaths.CannyCat__png);
        cannyCat.scale.set(defaultScale, defaultScale);
        cannyCat.updateHitbox();
        cannyCat.screenCenter();
        //cannyCat.blend = BlendMode.MULTIPLY;
        add(cannyCat);

        uncannyCat = new FlxSprite();
        uncannyCat.loadGraphic(AssetPaths.UncannyCat__png);
        uncannyCat.scale.set(defaultScale, defaultScale);
        uncannyCat.updateHitbox();
        uncannyCat.screenCenter();
        add(uncannyCat);
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        //clicking();
        lerpmovement();

        uncannyCat.scale.x = cannyCat.scale.x;
        uncannyCat.scale.y = cannyCat.scale.y;
        uncannyCat.alpha = canniness;

        #if debug
        if(FlxG.keys.pressed.LEFT)
        {
            canniness -= 0.01;
            trace(canniness);
        } else if(FlxG.keys.pressed.RIGHT){
            canniness += 0.01;
            trace(canniness);
        }
        #end
    }

    function clicking() 
    {
        if(FlxG.mouse.overlaps(cannyCat))
        {
            FlxTween.tween(cannyCat, { "scale.x": defaultScale + 0.05, "scale.y": defaultScale + 0.05}, 0.1, { ease: FlxEase.linear });
            if(FlxG.mouse.justReleased) 
            {
                FlxTween.cancelTweensOf(cannyCat);
                Values.updateMilkText();
                FlxTween.tween(cannyCat, { "scale.x": defaultScale - 0.3, "scale.y": defaultScale - 0.3}, 0.5, { ease: FlxEase.linear });
                playCannySounds();
            }
        } else {
            FlxTween.cancelTweensOf(cannyCat);
            FlxTween.tween(cannyCat, { "scale.x": defaultScale, "scale.y": defaultScale}, 0.1, { ease: FlxEase.linear });
        }
    }

    function lerpmovement()
    {
        if(FlxG.keys.justReleased.S)
        {
            randomX = FlxG.random.float(0, 1280);
            randomY = FlxG.random.float(0, 720);
        }
        cannyCat.x = FlxMath.lerp(cannyCat.x, randomX, 0.01);
        cannyCat.y = FlxMath.lerp(cannyCat.y, randomY, 0.01);
    }

    function playCannySounds()
    {
        cannySounds = [cannyHeh, cannyNah, cannyNyeh];

        var randomNumber = FlxG.random.int(0, 2);

		cannySounds[randomNumber].play(true);
		//trace(cannySounds);
		//trace(randomNumber);
    }

    function incrCanniness()
    {
        
    }
}