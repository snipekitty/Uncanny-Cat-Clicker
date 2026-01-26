package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class MiniGameState extends FlxState
{
    public static var didYouWin:Bool = false;
    var text:FlxText;

    override public function create() 
    {
        text = new FlxText(0, 0, 0, "press left to lose, right to win", 50);
        add(text);
        super.create();
    }

    override public function update(elapsed:Float) 
    {
        if(FlxG.keys.justPressed.LEFT)
        {
            didYouWin = false;
            CatTreat.finishedGame = true;
            CatTreat.isSpawned = true;
            FlxG.switchState(PlayState.new);
        } else if(FlxG.keys.justPressed.RIGHT){
            didYouWin = true;
            CatTreat.finishedGame = true;
            FlxG.switchState(PlayState.new);
        }
        super.update(elapsed);
    }
}