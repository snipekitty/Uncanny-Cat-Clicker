package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import hxvlc.flixel.FlxVideoSprite;

@:keep class CatNewsDisplayer extends FlxTypedGroup<FlxSprite>
{
    var catNewsDisplayer:FlxSprite;
    static var newsGif:FlxVideoSprite;
    public static var gifArray:Array<String>;

    static var changeTimer:Float;
    public static var randomNum:Int;

    public function new()
    {
        super();
        catNewsDisplayer = new FlxSprite();
		catNewsDisplayer.loadGraphic(AssetPaths.newstv__png);
		catNewsDisplayer.setPosition(0, FlxG.height - catNewsDisplayer.height);

        gifArray = ['assets/images/gifs/wdtggg.mp4', //0
        'assets/images/gifs/taiko.mp4', //1
        'assets/images/gifs/catsisyphus.mp4', //2 
        'assets/images/gifs/thevoices.mp4', //3
        'assets/images/gifs/soggycatmoney.mp4', //4,
        /*anything beyond this point is a special gif*/ 
        'assets/images/gifs/listening.mp4', //3
        ];

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
    }

    public static function playGif()
    {
        newsGif.load(gifArray[randomNum], [':input-repeat=1000']);
        newsGif.play();
    }
}