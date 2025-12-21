package;

import MainHud;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class RandomTreat extends FlxTypedGroup<FlxSprite>
{
    var catTreat:FlxSprite;
    var isSpawned:Bool = false;
    public static var isClicked:Bool = false;

    static var randomX:Int;
    static var randomY:Int;

    var spawnTimer:Float = 0;
    var leaveTimer:Float = 0;
    var multTimer:Float = 0;
    var randomNumber:Int = 0;

    var randomMultNum:Int = 0;

    public function new() 
    {   
        super();
        
        catTreat = new FlxSprite();
        catTreat.makeGraphic(50, 50, FlxColor.WHITE);
        catTreat.setPosition(0, 0);

        add(catTreat);
        catTreat.kill();
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
        spawnTreat();
        clicking();
        
        switch (isSpawned)
        {
            case true:            
                randomNumber = FlxG.random.int(0, 1);

                if(randomNumber == 1)
                {
                    catTreat.revive();
                    spawnTimer = 0;
                    leaveTimer += 1 * elapsed;
                }

            case false:
                catTreat.kill();
                leaveTimer = 0;
                if (MainHud.clicksPerSecond > 0)
                {                    
                    spawnTimer += 1 * elapsed;
                }
        }

        switch (isClicked)
        {
            case true:
                multTimer += 1 * elapsed;
                if (multTimer > 10)
                {
                    isClicked = false;
                    MainHud.clicksPerSecond = MainHud.clicksPerSecond / randomMultNum;
                }

            case false:
                multTimer = 0;
        }
    }

    function spawnTreat() 
    {
        if(spawnTimer > 1)
        {
            isSpawned = true;
            randomPos();
            catTreat.setPosition(randomX, randomY);
        } else if (leaveTimer > 500)
        {
            isSpawned = false;
            leaveTimer = 0;
        }
    }

    function randomPos()
    {
        randomX = FlxG.random.int(30, 450);
        randomY = FlxG.random.int(100, 440);
    }

    function clicking() 
    {
        if(isSpawned == true)
        {
            if(FlxG.mouse.overlaps(catTreat))
            {
                if(FlxG.mouse.justPressed)
                {
                    isSpawned = false;
                    isClicked = true;

                    randomMultNum = FlxG.random.int(10, 10000);

                    MainHud.clicksPerSecond = MainHud.clicksPerSecond * randomMultNum;
                }
            }  
        }
    }
}