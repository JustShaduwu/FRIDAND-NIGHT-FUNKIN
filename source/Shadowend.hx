package;
import flixel.*;

class Shadowend extends MusicBeatState
{

 public function new() 
 {
  super();
 }
 
 override function create() 
 {
  super.create();
  
  var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("unlocks"));
  add(bg);
  FlxG.sound.playMusic(Paths.music("andnother-medium"));
  
  
 }
 
 
 override function update(elapsed:Float) 
 {
  super.update(elapsed);
  
  
  if (controls.ACCEPT){
  FlxG.sound.playMusic(Paths.music("freakyMenu"));
     FlxG.switchState(new FreeplayState());
  }
 }
 
}