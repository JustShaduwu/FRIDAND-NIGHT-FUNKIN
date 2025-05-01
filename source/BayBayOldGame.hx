package;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxTimer;
import openfl.utils.Assets as OpenFlAssets;
import flixel.*;
#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

import flixel.util.FlxSave;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;
class BayBayOldGame extends MusicBeatState
{  
	public function new() 
	{
		super();
	}
	
    override function create()

    {
		FlxG.sound.playMusic(Paths.music('shhh'), 1, true);
        new FlxTimer().start(1, function(guh:FlxTimer) // gives a bit delay
        {
            startVideo('endportalgedon' + '-' + ClientPrefs.language); //put the video name here make sure the video on videos folder. you dont need to add like blabla.mp4 just blabla
        });
    }
	
    override function update(elapsed)
    {
        if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)   
		FlxG.switchState(new CustomCreditsState()); //uncomment this so if you press space or enter the intro will be skipped
		FlxG.save.data.whenevertrue;
        FlxG.save.data.whenevertrue;
        FlxG.save.flush();
    }
     

    function startVideo(name:String)
        {
            #if VIDEOS_ALLOWED
            var filepath:String = Paths.video(name);
            #if sys
            if(!FileSystem.exists(filepath))
            #else
            if(!OpenFlAssets.exists(filepath))
            #end
            {
                FlxG.log.warn('Couldnt find video file: ' + name);
                return;
            }


            var video:MP4Handler = new MP4Handler();
            video.playVideo(filepath);
            video.finishCallback = function()
            {
        FlxG.save.data.whenevertrue;
        FlxG.save.data.whenevertrue;
        FlxG.save.flush();
		
                FlxG.switchState(new CustomCreditsState());
						FlxG.sound.playMusic(Paths.music("freakyMenu"));
				//this will make after the video done it will switch to the intro text/ title state
                return;
            }

            #else
            FlxG.log.warn('Platform not supported!');
            return;
            #end
        }

}