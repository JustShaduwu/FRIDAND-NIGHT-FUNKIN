function onEndSong()
	if not allowEnd and isStoryMode then
		setProperty('inCutscene', true);
		startDialogue('post-dialogue', 'cutscene-and');
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end