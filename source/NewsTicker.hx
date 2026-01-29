package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class NewsTicker extends FlxTypedGroup<FlxSprite>
{
    var newsBar:FlxSprite;
    var newsText:FlxText;
    var newsTextArray:Array<String>;

    public function new()
    {
        super();

        newsBar = new FlxSprite();
        newsBar.makeGraphic(1400, 30, FlxColor.RED);
        newsBar.setPosition(0, FlxG.height - newsBar.height);

        newsText = new FlxText(0, 0, 0, "nothing", 25);
        newsText.setPosition(1400, FlxG.height - newsText.height);
        newsText.font = "assets/fonts/Comic Sans MS.ttf";

        newsTextArray = ["I love uncanny cat clicker!!!",
        "the quick brown fox might've actually not jumped over the lazy dog", 
        "nuke the whole generation", 
        "I love uncanny cat golf!!!",
        "have you ever had to play uncanny cat clicker with your life on the line !?!?",
        "yall gotta see this img_4758.png",
        "peaks of yore player DIES after trying to climb mt everest",
        "\"foreshadowing is a narrative device\"... -current best SEAL in the Navy SEALS, likely to graduate top of his class",
        "local man makes millions off casino \"we might still be okay\" -owner, before being struck by lightning 38 times in a row",
        "Local speedrunner beats minecraft any% world record WITHOUT backwards-long jumping.",
        "is foreshadowing a literary or a narrative device",
        "defeated with the SLIGHTEST bit of thinking",
        "sv_cheats 1",
        "https://www.youtube.com/@jamie-crazy",
        "the quote book is for… quotes that are somewhat \"outlandish\" for lack of a better term, not for normal sentences",
        "anything for +1 sb xp....",
        "connection failed after 4 retries"];

        newsText.text = newsTextArray[FlxG.random.int(0, newsTextArray.length - 1)];

        add(newsBar);
        add(newsText);
    }

    override public function update(elapsed:Float)
    {
        newsText.x -= 3;
        trace(newsText.x);

        if(newsText.x < -1600)
        {
            newsText.x = 1400;
            newsText.text = newsTextArray[FlxG.random.int(0, newsTextArray.length - 1)];
        }
        super.update(elapsed);
    }
}