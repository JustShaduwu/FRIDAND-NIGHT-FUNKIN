function onCreate()
	-- background shit
	--normal portal on
		makeLuaSprite('stagepilar', 'Bg/Portal_Pilar', -57, -250); --front
	setLuaSpriteScrollFactor('stagepilar', 2, 0.9); --front anim
	    scaleObject('stagepilar', 1.2,1.2); -- scale front

	makeLuaSprite('shadow', 'Bg/Portal_Shadow', -400, -250); --purple light
	    scaleObject('shadow', 1.2,1.2); --scale purple light
		
	makeLuaSprite('stageback', 'Bg/Screen_BG', -400, -250); --- bg
	    scaleObject('stageback', 1.2,1.2); --scale the bg
		
	makeLuaSprite('stagefront', 'Bg/Stage1', -400, -250); --front
	setLuaSpriteScrollFactor('stagefront', 0.9, 0.9); --front anim
	    scaleObject('stagefront', 1.2,1.2); -- scale front

	makeLuaSprite('light', 'Bg/Portal_Light', -400, -250); --purple light
	    scaleObject('light', 1.2,1.2); --scale purple light
		
	makeLuaSprite('floor', 'Bg/shadowfloor', -57, -250); --- floor no portal leak
	setLuaSpriteScrollFactor('floor', 2, 0.9); --front anim
	    scaleObject('floor', 1.2,1.2); --floor no portal leak
-- portal scar bg
--	makeLuaSprite('scar', 'Bg/StagePORTALSCAR', -370, -230);
--	scaleObject('scar', 1.2,1.2);

	addLuaSprite('floor', true);
	addLuaSprite('stagepilar', true);
	addLuaSprite('stageback', false);
	addLuaSprite('shadow', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('light', false);
	addLuaSprite('scar', false);
	doTweenAngle('stagebackTweenAngle', 'stageback', 43200,700, 'linear')
end
-- -350 + Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.5) * 12.5;¿q¿