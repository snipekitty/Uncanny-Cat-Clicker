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

    var defaultScale:Float = 0.8;

    public static var canniness:Float = -0.5;

    public function new() 
    {
        super();

        cannyCat = new FlxSprite();
        cannyCat.loadGraphic(AssetPaths.CannyCat__png);
        cannyCat.scale.set(defaultScale, defaultScale);
        cannyCat.updateHitbox();
        cannyCat.screenCenter();
        cannyCat.antialiasing = true;
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
        clicking();

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
            cannyCat.scale.x = FlxMath.lerp(cannyCat.scale.x, defaultScale + 0.1, 0.1);
            cannyCat.scale.y = FlxMath.lerp(cannyCat.scale.y, defaultScale + 0.1, 0.1);
            if(FlxG.mouse.justReleased) 
            {
                //FlxTween.cancelTweensOf(cannyCat);
                Values.updateMilkText();
                //FlxTween.tween(cannyCat, { "scale.x": defaultScale - 0.3, "scale.y": defaultScale - 0.3}, 0.5, { ease: FlxEase.linear });
                cannyCat.scale.x = FlxMath.lerp(defaultScale, cannyCat.scale.x - 0.1, 0.1);
                cannyCat.scale.y = FlxMath.lerp(defaultScale, cannyCat.scale.y - 0.1, 0.1);
                playCannySounds();
            }
        } else {
            cannyCat.scale.x = FlxMath.lerp(cannyCat.scale.x, defaultScale, 0.1);
            cannyCat.scale.y = FlxMath.lerp(cannyCat.scale.y, defaultScale, 0.1);
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

    function incrCanniness()
    {
        
    }
}