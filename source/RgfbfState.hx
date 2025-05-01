package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class RgfbfState extends FlxState
{
	override public function create()
	{
		super.create();
     //   var ugu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB2'));
        var ugu:FlxSprite = new FlxSprite().loadGraphic(Paths.image("ourbook/RB2"));
        ugu.screenCenter();
        add(ugu);
		FlxG.sound.playMusic(Paths.music('Reality YearBook/TutorialVer'), 1, true);
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
            FlxG.switchState(new RBMState());
    }

    if (FlxG.keys.pressed.RIGHT && StoryMenuState.weekCompleted.get('andweek1'))
    {
            FlxG.switchState(new RbandState());
    }
}
}