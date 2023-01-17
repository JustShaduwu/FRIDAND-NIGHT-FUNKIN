function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Shadow Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Shadow_Notes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'Shadow_Notes_splashes'); -- change splash
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
--Spanish remember: Estas notas unicamente se usaran para la cancion "Shadow", en canciones posteriores donde vuelva a cantar Shadow And se utilizaran flechas normales, pero color rojo y negro u blanco.
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Shadow Note' then
    makeLuaSprite('vignette', 'vignette', 0, 0);
    setObjectCamera('vignette', 'other');
    addLuaSprite('vignette', true);
    doTweenAlpha('vignette', 'vignette', 0, 2, 'sineInOut');

    makeLuaSprite('black', 'black', 0, 0);
    setObjectCamera('black', 'other');
    addLuaSprite('black', true);
    doTweenAlpha('black', 'black', 0, 0.5, 'sineInOut');
	
	setProperty('health', 1);
	end
end