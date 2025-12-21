package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class RandomTreat extends FlxTypedGroup<FlxSprite>
{
    var catTreat:FlxSprite;
    var isSpawned:Bool = false;

    static var randomX:Int;
    static var randomY:Int;

    var spawnTimer:Float;
    var leaveTimer:Float;

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
        
        switch (isSpawned)
        {
            case true:
                catTreat.revive();
                spawnTimer = 0;
                leaveTimer += 1 * elapsed;
            case false:
                catTreat.kill();
                spawnTimer += 1 * elapsed;
        }
    }
// 5 minutes and then coinflip every second
    function spawnTreat() 
    {
        if(spawnTimer > 0.5)
        {
            isSpawned = true;
            randomPos();
            catTreat.setPosition(randomX, randomY);
        } else if (leaveTimer > 13)
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
}