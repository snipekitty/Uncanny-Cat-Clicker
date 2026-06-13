package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import hxvlc.flixel.FlxVideoSprite;

class CatNewsDisplayer extends FlxTypedGroup<FlxSprite>
{
    var catNewsDisplayer:FlxSprite;
    var newsGif:FlxVideoSprite;
    var gifArray:Array<String>;

    var scaleX:Float;
    var scaleY:Float;
    var changeTimer:Float;

    public function new()
    {
        super();
        catNewsDisplayer = new FlxSprite();
		catNewsDisplayer.loadGraphic(AssetPaths.newstv__png);
		catNewsDisplayer.setPosition(0, FlxG.height - catNewsDisplayer.height);

        gifArray = ['assets/images/gifs/wdtggg.mp4', 'assets/images/gifs/taiko.mp4'];

        newsGif = new FlxVideoSprite();
        newsGif.load(gifArray[FlxG.random.int(0, gifArray.length - 1)], [':input-repeat=1000']);
        newsGif.play();

        add(newsGif);
        add(catNewsDisplayer);
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
        changeTimer += 1 * elapsed;
        if(changeTimer > 2)
        {
            newsGif.load(gifArray[FlxG.random.int(0, gifArray.length - 1)], [':input-repeat=1000']);
            newsGif.play();
            changeTimer = 0;
        }
    }
}