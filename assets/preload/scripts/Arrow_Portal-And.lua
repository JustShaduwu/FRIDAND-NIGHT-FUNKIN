function onUpdate(elapsed)
	if dadName == 'and-og-first' then 
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
--FOR ANOYED PORTAL AND