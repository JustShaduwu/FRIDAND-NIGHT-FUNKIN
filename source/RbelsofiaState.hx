package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class RbelsofiaState extends FlxState
{
	override public function create()
	{
		super.create();
        var ubu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB4'));
        var ubu:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ourbook/RB4"));
        ubu.screenCenter();
        add(ubu);
	    FlxG.sound.playMusic(Paths.music('Reality YearBook/HikaruWavesVer'), 1, true);
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
            FlxG.switchState(new RbandState());
    }
	
    if (FlxG.keys.pressed.RIGHT)
    {
            FlxG.switchState(new RbdayaguelState());
    }
}
}