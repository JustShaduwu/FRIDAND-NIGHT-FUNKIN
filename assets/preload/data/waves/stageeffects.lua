function onCreate()
	makeLuaSprite('fgb', 'Bg/Friends/darkscreen', -200, -200);
    scaleObject('fgb', 2.2,2.2); -- scale front
	addLuaSprite('fgb', false);	
	
	makeAnimatedLuaSprite('draw', 'Bg/Friends/WavesDoodles', 0, -5); -- doodle
	addAnimationByPrefix('draw', 'idle', 'wavesdraws', 48, true);
	addLuaSprite('draw', true);	
	setObjectCamera('draw','camHud')
doTweenAlpha('fgb','fgb',0, 0.1,'linear')
doTweenAlpha('draw','draw',0, 0.1,'linear')
end
function onUpdatePost()
if curBeat == 79 then --change curBeat to whatever
    doTweenAlpha('fgb','fgb',1, 1,'linear')
	doTweenAlpha('draw','draw',1, 1,'linear')
end
if curBeat == 135 then --change curBeat to whatever
    doTweenAlpha('fgb','fgb',0, 0.1,'linear')
	doTweenAlpha('draw','draw',0, 0.1,'linear')
end
end
