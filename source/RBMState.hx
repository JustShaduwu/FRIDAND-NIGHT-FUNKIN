package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class RBMState extends FlxState
{
	override public function create()
	{
		super.create();
        var uwu = new FlxSprite().loadGraphic(Paths.image('ourbook/RB1'));
        uwu.screenCenter();
        add(uwu);
        FlxG.sound.playMusic(Paths.music('offsetSong'), 1, true);
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Reality Yearbook", null);
		#end
	}

	override public function update(elapsed:Float):Void
{
    if (FlxG.keys.pressed.ESCAPE)
    {
             FlxG.sound.playMusic(Paths.music("freakyMenu"));
             FlxG.switchState(new MainMenuState());
    }

    if (FlxG.keys.pressed.RIGHT)
    {
            FlxG.switchState(new RgfbfState());
    }

    if (FlxG.keys.pressed.UP)
    {
            FlxG.switchState(new GalleryState());
    }
	
    if (FlxG.keys.pressed.DOWN)
    {
            FlxG.switchState(new PortalTunesState());
    }
}
}