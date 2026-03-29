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
        newsText.antialiasing = true;
        newsText.pixelPerfectPosition = true;
        newsText.pixelPerfectRender = true;

        newsTextArray = ["I love uncanny cat clicker!!!", //0
        "the quick brown fox might've actually not jumped over the lazy dog", //1
        "nuke the whole generation", //2
        "Play uncanny cat golf!!!", //3
        "have you ever had to play uncanny cat clicker with your life on the line", //4
        "yall gotta see this img_4758.png", //5
        "peaks of yore player DIES after trying to climb mt everest", //6
        "\"foreshadowing is a narrative device\"... -current best SEAL in the Navy SEALS, likely to graduate top of his class", //7
        "local man makes millions off casino \"we might still be okay\" -owner, before being struck by lightning 38 times in a row", //8
        "Local speedrunner beats minecraft any% world record WITHOUT backwards-long jumping.", //9
        "is foreshadowing a literary or a narrative device", //10
        "defeated with the SLIGHTEST bit of thinking", //11
        "sv_cheats 1", //12
        "https://www.youtube.com/@jamie-crazy", //13
        "the quote book is for… quotes that are somewhat \"outlandish\" for lack of a better term, not for normal sentences", //14
        "ANYTHING for +1 skyblock xp....", //15
        "connection failed after 4 retries", //16
        "if valve wont make 3, hevi wont make 9, i wont make 27, then who isnt gonna make 81?", //17
        "rage tag = hit the road", //18
        "I PLEDGE ALLEGIANCE TO THE GRIND", //19
        "https://www.youtube.com/watch?v=GiaD7WSdb4M", //20
        "admin he doin it sideways", //21
        "always buy the dip", //22
        "\"the cars are carrying me\"", //23
        "i'm like hey what's up hello", //24
        "PINK CANDY BOOOOOOM", //25
        "at 100% speed, does this look possible to you?", //26
        "hey buddy. we're going to kill you and leave you laid out in a dumpster to rot", //27
        "yuri vs yaoi", //28
        "HOW TO GURNEY IN STRAFTAT (BROKEN META) (WORKING 2026) (NOT PATCHED) (NOT CLICKBAIT)", //29
        "GOLD GOLD GOLD GOLD GOLD !!!!!", //30
        "\"90% of the internet is a lie\" - Abraham Lincoln", //31
        "99% of gamblers quit before they hit it big", //32
        "75% of statistics are made up on the spot", //33
        "the game", //34
        "bully WILL be a 10/10 album", //35
        "RUSH B RUSH B RUSH B", //36
        "He was a serial killer! He bragged about killing people!", //37
        "Uncanny cat clicker? More like", //38
        "behind you", //39
        "repost if chilling", //40
        "the skyblock hood life aint easy. Fake ass MFs who could snitch just to get another macroer banned. Watch out for snakes in skyblock...", //41
        "meow meow mrp (KITTY TRANSLATION...) jump off", //42
        "GTA 6 delayed AGAIN", //43
        "The plant shivers when chicot loses its temper", //44
        "There's HOW many proofs to the Pythagorean theorem?!", //45
        "Uncanny cat clicker confirmed to be in development hell", //46
        "counter strike player finally gets his first 7k (emotional)", //47
        "2016 but Gen Z childhood", //48
        "he did WHAT to a mcchicken???", //49
        "if(newsText.overlaps(newsBar) == false){ newsText.x = 1400; newsText.text = newsTextArray[FlxG.random.int(0, newsTextArray.length - 1)]; }", //50
        "it says gullible on the ceiling", //51
        "tired of holding my horses..", //52
        "crazy? i was crazy once", //53
        "the voices", //54
        "ref DO SOMETHING", //55
        "uncanny cat clicker confirmed to be made of spaghetti", //56
        "You are currently in the Uncanny Cat Universe (no active Challenges)", //57
        "yeah i can code: ", //58
        "oral dave at the coral cave", //59
        "the thought of wingstop is better than wingstop", //60
        "The game \"Canny Cat Clicker\" by pistol has now completed development", //61
        "\"Once, my dad told me: Respect everyone but fear no one, except for Herobrine\" - Kendrick  Lamar", //62
        "our BRAINS are GONE", //63
        "how it feels to stop listening to people and just kill them", //64
        "let us RUMINATE on this for a brief moment! might it be possible that his ABILITIES in crafting works of LITERATURE that stand amongst the LIKES of such LEGENDS as WILLIAM SHAKESPEARE, CHARLES DICKENS, and others are this POTENT!?", //65
        "hold up his writing is fire!?", //66
        "i dont need a rope for that jump!", //67
        "16 point crampons are real", //68
        "how to do extended hyperdash in real life", //69
        "honestly quite incredible", //70
        "Uncanny Cat doesn't need to hear all this, they're a highly trained professional!", //71
        "babe wake up new jamie upload", //72
        "Why am I alive? Why do you care?", //73
        "\"to my fans, thank you for being loyal and patient, I cant finish uncanny cat clicker because there's a bee in the studio\"", //74
        "if you see this newsticker it means something has gone horribly wrong, a fix is on my website https://www.brintendo.com/", //75
        ];

        newsText.text = newsTextArray[FlxG.random.int(0, newsTextArray.length - 1)];
        newsText.updateHitbox();

        add(newsBar);
        add(newsText);
    }

    override public function update(elapsed:Float)
    {
        newsText.x -= 3;
        //trace(elapsed);
        //trace(newsText.x);

        if(newsText.overlaps(newsBar) == false)
        {
            trace("you did a loop");
            newsText.x = 1400;
            newsText.text = newsTextArray[FlxG.random.int(0, newsTextArray.length - 1)];
            newsText.updateHitbox();
        }
        super.update(elapsed);
    }
}