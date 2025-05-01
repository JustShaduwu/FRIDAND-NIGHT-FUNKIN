package;
import flixel.*;

/**
 * ...
 * @author bbpanzu
 */
class End extends MusicBeatState
{

	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();
		
		var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("ends/unlocks"));
		add(bg);
		FlxG.sound.playMusic(Paths.music("andnother-medium"));
		
		
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
	if (controls.ACCEPT)
	{
	FlxG.sound.playMusic(Paths.music("freakyMenu"));
		FlxG.switchState(new FreeplayState());
	}
    if (FlxG.keys.pressed.ESCAPE)
    {
    FlxG.sound.playMusic(Paths.music("freakyMenu"));
        FlxG.switchState(new FreeplayState());
    }
	
	if (FlxG.keys.pressed.BACKSPACE)
    {
    FlxG.sound.playMusic(Paths.music("freakyMenu"));
        FlxG.switchState(new FreeplayState());
    }
	
	}
}