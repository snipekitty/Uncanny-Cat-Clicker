package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import hxvlc.flixel.FlxVideoSprite;

class CatNewsDisplayer extends FlxTypedGroup<FlxSprite>
{
    var catNewsDisplayer:FlxSprite;
    var newsGif:FlxVideoSprite;
    var gifArray:Array<String>;

    var changeTimer:Float;
    public static var randomNum:Float;

    public function new()
    {
        super();
        catNewsDisplayer = new FlxSprite();
		catNewsDisplayer.loadGraphic(AssetPaths.newstv__png);
		catNewsDisplayer.setPosition(0, FlxG.height - catNewsDisplayer.height);

        gifArray = ['assets/images/gifs/wdtggg.mp4', 'assets/images/gifs/taiko.mp4', 'assets/images/gifs/listening.mp4'];

        newsGif = new FlxVideoSprite();
        newsGif.setPosition(34,550);
        newsGif.load(gifArray[FlxG.random.int(0, gifArray.length - 2)], [':input-repeat=1000']);
        newsGif.play();
        newsGif.updateHitbox();

        add(newsGif);
        add(catNewsDisplayer);
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        changeTimer += 1 * elapsed;
        if(changeTimer > 10)
        {
            newsGif.load(gifArray[/*FlxG.random.int(0, gifArray.length - 2)*/ 2], [':input-repeat=1000']);
            newsGif.play();
            changeTimer = 0;
        }
    }

    public static function requestedGif()
    {
        
    }
}