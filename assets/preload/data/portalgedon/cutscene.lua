
local allowCountdown = false

function onCreate()
	setPropertyFromClass('flixel.FlxG','sound.music.volume',0)
	setProperty('skipCountdown',true)
	setProperty('vocals.time',0)
	
	makeLuaSprite('light', 'Bg/Portal_Light', -400, -250); --purple light
    scaleObject('light', 1.2,1.2); --scale purple light
	
makeLuaSprite('black', 'Bg/Friends/darkscreen', -1000, -200);
addLuaSprite('black', true);
scaleObject('black', 900, 900); -- scale front
doTweenAlpha('blackFadeEventTween', 'black', 0, 0.1,'linear')


	addLuaSprite('light', false);
	
	
    setObjectOrder('light', 7)

end

function onStartCountdown() -- No countdown yet
    if not allowCountdown then
	    return Function_Stop
	end

	if allowCountdown then
	    return Function_Continue
	end
end

function onCreatePost()
	setProperty('vocals.volume',0)
	setProperty('vocals.time',0)
    doTweenAlpha('dad','dad',0, 0.1,'linear')
	
	runTimer('fadeTimer', 3.0, 1)
addCharacterToList('elsa-og', 'dad')
addCharacterToList('yolo-og', 'dad')
addCharacterToList('miguel-og', 'dad')
addCharacterToList('sofia-og', 'dad')
addCharacterToList('dayami-og', 'dad')	
end

function onSongStart()
	setProperty('vocals.volume',1)
	setProperty('vocals.time',0)
	setPropertyFromClass('flixel.FlxG','sound.music.volume',1)
end

function onBeatHit()
	if curBeat % 32 == 0 then
    doTweenAlpha('dad','dad',1, 0.1,'linear')
	end
	if curBeat % 512 == 0 then
	noteTweenX('oppo0', 0, -1000, 1.5, 'quartInOut')
	noteTweenX('oppo1', 1, -1000, 1.5, 'quartInOut')
	noteTweenX('oppo2', 2, -1000, 1.5, 'quartInOut')
	noteTweenX('oppo3', 3, -1000, 1.5, 'quartInOut')
	noteTweenAngle('opporotate0', 0, 360, 1, 'quartInOut')
	noteTweenAngle('opporotate1', 1, 360, 1, 'quartInOut')
	noteTweenAngle('opporotate2', 2, 360, 1, 'quartInOut')
	noteTweenAngle('opporotate3', 3, 360, 1, 'quartInOut')
	noteTweenX('play0', 4, 415, 1, 'quartInOut')
	noteTweenX('play1', 5, 525, 1, 'quartInOut')
	noteTweenX('play2', 6, 635, 1, 'quartInOut')
	noteTweenX('play3', 7, 745, 1, 'quartInOut')
	noteTweenAngle('playrotate0', 4, 360, 1, 'quartInOut')
	noteTweenAngle('playrotate1', 5, 360, 1, 'quartInOut')
	noteTweenAngle('playrotate2', 6, 360, 1, 'quartInOut')
	noteTweenAngle('playrotate3', 7, 360, 1, 'quartInOut')
	end
end

function onTimerCompleted(tag) -- bye bye loading screen
    if tag == 'fadeTimer' then
			playSound('startMenu',0.8);
		allowCountdown = true
		startCountdown()
  doTweenAlpha('blackFadeEventTween', 'black', 1, 10,'linear')		
	end
end