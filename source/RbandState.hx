package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class RbandState extends FlxState
{
	override public function create()
	{
		super.create();
       // var unu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB3'));
        var unu:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ourbook/RB3"));
        unu.screenCenter();
        add(unu);
	    FlxG.sound.playMusic(Paths.music('Reality YearBook/AndWeekVer'), 1, true);
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
            FlxG.switchState(new RgfbfState());
    }
	
    if (FlxG.keys.pressed.RIGHT && StoryMenuState.weekCompleted.get('friendsweek2'))
    {
            FlxG.switchState(new RbelsofiaState());
    }
}
}