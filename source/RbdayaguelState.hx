package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class RbdayaguelState extends FlxState
{
	override public function create()
	{
		super.create();
     //   var uxu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB5'));
        var uxu:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ourbook/RB5"));
        uxu.screenCenter();
        add(uxu);
	    FlxG.sound.playMusic(Paths.music('Reality YearBook/TenexChanVer'), 1, true);
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
            FlxG.switchState(new RbelsofiaState());
    }
	
    if (FlxG.keys.pressed.RIGHT)
    {
            FlxG.switchState(new RbyoloneState());
    }
}
}