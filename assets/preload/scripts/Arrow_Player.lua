function onUpdate(elapsed)
    if boyfriendName == 'playable-and-og' then 
		for i=0,4,1 do
			setPropertyFromGroup('playerStrums', i, 'texture', 'And_Notes')
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'texture', 'And_Notes'); --SOMEONE SAY ME HOW TO PUT SPLASHES TEXTUREEEES AHHHH
			end
		end
	end
end
--FOR PLAYABLE AND OG