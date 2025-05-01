--local allowEnd = false;
local playDialogue = false;
function onEndSong()
	if not allowEnd and isStoryMode then
    startDialogue('post-dialogue', 'cutscene-together-whenever');
allowEnd = true;
playDialogue = true;
		return Function_Stop;
elseif playDialogue then
setProperty('inCutscene', true);
runTimer('startDialogue', 0.8);
playDialogue = false;
return function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
if tag == 'startDialogue' then
		startVideo('endportalgedon-'..(lang));
		end
end