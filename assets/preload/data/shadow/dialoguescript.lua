local allowCountdown = false;
local playDialogue = false;
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		triggerEvent('Play Animation', 'INTROidle', 'dad')
		startVideo('introshadow');
		allowCountdown = true;
		playDialogue = true;
		return Function_Stop;
	elseif playDialogue then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		playDialogue = false;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'andnother-medium');
	end
end

function onCountdownTick(swagCounter)
	if swagCounter == 0 then
        triggerEvent('Play Animation', 'countdown3', 'gf')
	    triggerEvent('Play Animation', 'INTRO', 'dad')
	end
	if swagCounter == 1 then
        triggerEvent('Play Animation', 'countdown2', 'gf')
	end
	if swagCounter == 2 then
        triggerEvent('Play Animation', 'countdown1', 'gf')
	end
	if swagCounter == 3 then
        triggerEvent('Play Animation', 'sad', 'gf')
        triggerEvent('Play Animation', 'scared', 'bf')
	end
end