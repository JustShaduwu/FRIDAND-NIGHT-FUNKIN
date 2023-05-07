function onUpdate(elapsed)
	if dadName == 'and-og-first' then --Portal
		for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'And_Notes')
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'And_Notes'); 
			end
		end
	end
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
	if dadName == 'shadowand-og' then --DARK, for Shadow
		for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'Shadow_Notes')
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'Shadow_Notes'); 
			end
		end
	    if curStep >= 0 then --Tengo la sospecha de q el lag proviene de que el juego tenga que abrir tantos scripts, asi que, la mayoria de stages se van directo al source, y combinare scripts para intentar optimizar, espero jsksk
  
		songPos = getSongPosition()
  
		local currentBeat = (songPos/1000)*(bpm/80)
  
		doTweenY(dadTweenY, 'dad', 30-110*math.sin((currentBeat*0.25)*math.pi),0.001)
  
	  end
	end
end
--FOR PLAYABLE AND OG