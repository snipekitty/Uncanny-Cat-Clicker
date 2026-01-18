package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class CatTreat extends FlxTypedGroup<FlxSprite>
{
    
    // todo, when minigames get implemented make it so when you click the treat you get sent to a minigame and if you win you get the mult, otherwise do something else idk yet

    public static var catTreat:FlxSprite;

    var randomX:Int;
    var randomY:Int;

    var notifText:FlxText;
    var notifTimer:FlxTimer;

    var multTimer:Float = 0;
    public static var multNumbers:Array<Int>;
    public static var randomNumber:Int;
    static var randomSpawnNum:Int;

    public static var isClicked:Bool = false;
    var isSpawned:Bool = false;

    var spawnTimer:Float;
    var leaveTimer:FlxTimer;

    var clickSound = FlxG.sound.load(AssetPaths.squish__wav);
    
    public function new()
    {
        super();
        catTreat = new FlxSprite();
        catTreat.loadGraphic(AssetPaths.cattreat__png);
        catTreat.scale.set(0.2, 0.2);
        catTreat.updateHitbox();
        catTreat.setPosition(0, 0);
        add(catTreat);
        catTreat.kill();

        notifText = new FlxText(0, 0, 0, "placeholder", 40);
        notifText.color = FlxColor.CYAN;
        notifText.font = "assets/fonts/Comic Sans MS.ttf";
        notifText.antialiasing = true;
        add(notifText);
        notifText.kill(); 
        
        multNumbers = [10, 33, 50, 100];
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);

        clickTreat();
        
        if(isSpawned == false)
        {
            spawnTimer += 1 * elapsed;
            if(spawnTimer > 350)
            {
                trace("randomize number");
                randomSpawnNum = FlxG.random.int(0, 1);
                if(randomSpawnNum == 1)
                {
                    spawnTimer = 0;
                    isSpawned = true;
                    trace("spawned");
                    spawnTreat();
                } else {
                    trace("failed");
                    spawnTimer = 0;
                }
            }
        }

        #if debug
        if(FlxG.keys.justPressed.A)
        {
            if(isSpawned == false)
            {
                isSpawned = true;
                trace("spawned");
                spawnTreat();
            }
        }
        #end

        if(isClicked == true)
        {
            multTimer += 1 * elapsed;
            trace(multTimer);
            
            if(multTimer > 3)
            {
                multTimer = 0;
                MainHud.clicksPerSecond = MainHud.cpsOld;
                isClicked = false;
                isSpawned = false;
            }
        }
        
    }

    function spawnTreat()
    {
        randomPos();
        catTreat.setPosition(randomX, randomY);
        catTreat.revive();
        leaveTimer = new FlxTimer().start(13, leave ->{isSpawned = false; catTreat.kill(); leaveTimer.destroy();});
    }

    function clickTreat() 
    {
        if(catTreat.alive == true)
        {
            if(FlxG.mouse.overlaps(catTreat))
            {
                if(FlxG.mouse.justReleased)
                {
                    isClicked = true;
                    if(isClicked == true)
                    {
                        leaveTimer.destroy();
                        catTreat.kill();
                        multTimer = 0;
                        MainHud.cpsOld = MainHud.clicksPerSecond;
                        //later will be determined by how well you do in the game, just random for testing i guess
                        randomNumber = FlxG.random.int(0, multNumbers.length - 1);
                        MainHud.clicksPerSecond *= multNumbers[randomNumber];
                        clickSound.play(true);
                    }
                    displayNotif();
                }
            }
        }
    }

    function randomPos() 
    {
        randomX = FlxG.random.int(30, 450);
        randomY = FlxG.random.int(100, 440);    
    }

    function displayNotif()
    {
        if(isClicked == true)
        {
            notifText.text ="YOU WON " + multNumbers[randomNumber] + " x YOUR Milk PER SECOND !!!";
            notifText.setPosition(catTreat.x, catTreat.y);
            notifText.revive();
            notifTimer = new FlxTimer().start(1.0, notifTimer ->{ notifText.kill(); notifTimer.destroy;});
            /* would be formatted as a switch statement probably?
            something like
            if true YOU WON !!!
            if false YOU LOST ???
            */
        }
    }
}