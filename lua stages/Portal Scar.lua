function onCreate()
	-- background shit
	makeLuaSprite('stage', 'Bg/StagePORTALSCAR', -400, -250);
	    scaleObject('stage', 1.2,1.2);
	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
	
	end

	addLuaSprite('stage', false);
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
-- -350 + Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.5) * 12.5;