function onSongStart()
	setProperty('songLength', 97000) --fake songLength, in milliseconds
end

function onUpdatePost()
	if getProperty('songLength') < songLength and curBeat >= 200 then --change curBeat to whatever
		if (getProperty('songLength') + 900) < songLength then
			setProperty('songLength', getProperty('songLength')+90000) --add 1 second to length
		else
			setProperty('songLength', songLength)
		end
	end
end