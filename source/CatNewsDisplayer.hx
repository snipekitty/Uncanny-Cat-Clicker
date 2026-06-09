package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flxgif.FlxGifAsset;
import flxgif.FlxGifSprite;

class CatNewsDisplayer extends FlxTypedGroup<FlxSprite>
{
    var catNewsDisplayer:FlxSprite;
    var newsGif:FlxGifSprite;
    var gifArray:Array<String>;

    var scaleX:Float;
    var scaleY:Float;

    public function new()
    {
        super();
        catNewsDisplayer = new FlxSprite();
		catNewsDisplayer.loadGraphic(AssetPaths.newstv__png);
		catNewsDisplayer.setPosition(0, FlxG.height - catNewsDisplayer.height);

        newsGif = new FlxGifSprite();
        newsGif.loadGif('assets/images/gifs/wdtggg.gif');
        newsGif.updateHitbox;
        scaleX = 154/newsGif.width;
        scaleY = 118/newsGif.height;
        newsGif.setPosition(-92, 521);
        newsGif.scale.set(scaleX, scaleY);
        newsGif.updateHitbox;

        add(newsGif);
        add(catNewsDisplayer);
    }

    override public function update(elapsed:Float) 
    {
        super.update(elapsed);
    }
}