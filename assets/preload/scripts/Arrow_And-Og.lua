function onUpdate(elapsed)
	if dadName == 'and-og' then --Regular. From Post Intro Alone, and Freeplay song, etc
		for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'And_Notes')
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'And_Notes'); 
			end
		end
	end
end