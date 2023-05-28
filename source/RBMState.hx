package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class RBMState extends FlxState
{
	override public function create()
	{
		super.create();
        var uwu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB1'));
        uwu.screenCenter();
        add(uwu);
        FlxG.sound.playMusic(Paths.music('Reality YearBook/DiaryHourOfLReading'), 1, true);
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Reality Yearbook", null);
		#end
		var bookinfo:FlxText = new FlxText(12, FlxG.height - 44, 0, Language.rbadd, 12);
		add(bookinfo);
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

    if (FlxG.keys.pressed.RIGHT && StoryMenuState.weekCompleted.get('tutorialremix'))
    {
            FlxG.switchState(new RgfbfState());
    }
}
}