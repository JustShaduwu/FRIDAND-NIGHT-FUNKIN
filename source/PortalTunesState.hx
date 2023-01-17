package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;

class PortalTunesState extends FlxState
{
	override public function create()
	{
		super.create();
        FlxG.sound.playMusic(Paths.music('offsetSong'), 1, true);
	}

	override public function update(elapsed:Float):Void
{
    if (FlxG.keys.pressed.UP)
    {
	         FlxG.sound.playMusic(Paths.music('offsetSong'), 1, false);
             FlxG.sound.playMusic(Paths.music("freakyMenu"), 1, true);
    }
}
}