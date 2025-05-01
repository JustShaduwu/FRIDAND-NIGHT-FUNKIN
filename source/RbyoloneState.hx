package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class RbyoloneState extends FlxState
{
	override public function create()
	{
		super.create();
  //      var uzu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB6'));
        var uzu:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ourbook/RB6"));
        uzu.screenCenter();
        add(uzu);
	    FlxG.sound.playMusic(Paths.music('Reality YearBook/SilentVer'), 1, true);
        FlxG.sound.play(Paths.sound('Pagen', 'preload'));
	}

	override public function update(elapsed:Float):Void
{
    if (FlxG.keys.pressed.ESCAPE)
    {
		    FlxG.sound.playMusic(Paths.music("freakyMenu"));
            FlxG.switchState(new MainMenuState());
    }
	
	if (FlxG.keys.pressed.BACKSPACE)
    {
             FlxG.sound.playMusic(Paths.music("freakyMenu"));
             FlxG.switchState(new MainMenuState());
    }

    if (FlxG.keys.pressed.LEFT)
    {
            FlxG.switchState(new RbdayaguelState());
    }
}
}