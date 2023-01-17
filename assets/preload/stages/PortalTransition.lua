function onCreate()
	-- background shit
	--normal portal on
	makeLuaSprite('stageback', 'Bg/Screen_BG', -400, -250); --- bg
	    scaleObject('stageback', 1.2,1.2); --scale the bg
		
	makeLuaSprite('stagefront', 'Bg/Stage1', -400, -250); --front
	setLuaSpriteScrollFactor('stagefront', 0.9, 0.9); --front anim
	    scaleObject('stagefront', 1.2,1.2); -- scale front

	makeLuaSprite('light', 'Bg/Portal_Light', -400, -250); --purple light
	    scaleObject('light', 1.2,1.2); --scale purple light
-- portal scar bg
	makeLuaSprite('scar', 'Bg/StagePORTALSCAR', -370, -230);
	scaleObject('scar', 1.2,1.2);
	

	addLuaSprite('stageback', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('light', false);
    setProperty('scar.alpha', 0);
	addLuaSprite('scar', false);
end
-- -350 + Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.5) * 12.5;¿q¿