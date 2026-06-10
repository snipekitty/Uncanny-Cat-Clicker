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
import haxe.Log;
import openfl.display.BlendMode;
import openfl.display.FPS;

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
    var concurrentFPS:FPS;

    var timer:FlxTimer;
    static var thoughtBubble:FlxSprite;

    public static var hunger:Float;
    public static var cleanliness:Float;
    public static var sleepiness:Float;

    public static var canniness:Float = -0.5;

    static var thBubbleMsg:FlxText;

    static var msgTimer:FlxTimer;

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

        concurrentFPS = new FPS(5000, 5000);

        uncannyCat = new FlxSprite();
        uncannyCat.loadGraphic(AssetPaths.UncannyCat__png);
        uncannyCat.scale.set(defaultScale, defaultScale);
        uncannyCat.updateHitbox();
        uncannyCat.screenCenter();
        add(uncannyCat);

        thoughtBubble = new FlxSprite(800, 215);
        thoughtBubble.loadGraphic(AssetPaths.ThoughtBubble__png);
        thoughtBubble.updateHitbox;
        add(thoughtBubble);
        thoughtBubble.kill();

        thBubbleMsg = new FlxText(thoughtBubble.x + 40, thoughtBubble.y + 30, thoughtBubble.width - 30, "", 24);
        add(thBubbleMsg);
        thBubbleMsg.kill();
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        clicking();
        incrCanniness();

        uncannyCat.scale.x = cannyCat.scale.x;
        uncannyCat.scale.y = cannyCat.scale.y;
        uncannyCat.alpha = canniness;

        #if debug
        if(FlxG.keys.pressed.LEFT)
        {
            canniness -= 1 * elapsed;
            trace(canniness);
        } else if(FlxG.keys.pressed.RIGHT){
            canniness += 1 * elapsed;
            trace(canniness);
        }
        #end
    }

    function clicking() 
    {
        if(FlxG.mouse.overlaps(cannyCat))
        {
            cannyCat.scale.x = FlxMath.lerp(cannyCat.scale.x, defaultScale + 0.1, 1 - Math.pow(0.005, FlxG.elapsed));
            cannyCat.scale.y = FlxMath.lerp(cannyCat.scale.y, defaultScale + 0.1, 1 - Math.pow(0.005, FlxG.elapsed));
            if(FlxG.mouse.justReleased) 
            {
                //FlxTween.cancelTweensOf(cannyCat);
                Values.updateMilkText();
                cannyCat.scale.x = FlxMath.lerp(defaultScale, cannyCat.scale.x - 0.1, 1 - Math.pow(0.005, FlxG.elapsed));
                cannyCat.scale.y = FlxMath.lerp(defaultScale, cannyCat.scale.y - 0.1, 1 - Math.pow(0.005, FlxG.elapsed));
                playCannySounds();
            }
        } else {
            cannyCat.scale.x = FlxMath.lerp(cannyCat.scale.x, defaultScale, 1 - Math.pow(0.005, FlxG.elapsed));
            cannyCat.scale.y = FlxMath.lerp(cannyCat.scale.y, defaultScale, 1 - Math.pow(0.005, FlxG.elapsed));
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
        if(Values.clicksPerSecond > 0)
        {
            if(FlxG.random.bool(1 + Values.clicksPerSecond/2000))
            {
                canniness += (0.1) * FlxG.elapsed;
                trace("increase");
            } else {
                //it'll do nothing 
                //trace("failed");
            }

            if(FlxG.mouse.overlaps(cannyCat))
            {
                if(FlxG.mouse.justReleased)
                {
                    if(FlxG.random.bool(1))
                    {
                        canniness += 0.01;
                        trace("increase(clicked)");
                    }
                }
            }
        } 
    }

    public static function checkStats()
    {
        if(hunger < 50)
        {
            thoughtBubble.revive();
            thBubbleMsg.text = "im not hungry bro!";
            thBubbleMsg.revive();
            trace("im not hungry");
            FlxG.sound.load(AssetPaths.notification__wav).play(true);
            msgTimer = new FlxTimer().start(2.0, msgTimer ->{ thoughtBubble.kill(); thBubbleMsg.kill(); msgTimer.destroy; });
        } else {
            trace("thank you bro");
        }
    }
}