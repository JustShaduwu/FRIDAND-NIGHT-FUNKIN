function onUpdate(elapsed)
	if dadName == 'shadow-and-body-og' then --For Shadow Song, and character. Note for me: Make new notes for.... The future...
		for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'texture', 'Shadow_Notes')
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'Shadow_Notes'); 
			end
		end
	end
end