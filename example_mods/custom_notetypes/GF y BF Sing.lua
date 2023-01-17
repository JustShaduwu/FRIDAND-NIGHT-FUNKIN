function goodNoteHit(id,dir,type,sus)
	if type == 'GF y BF Sing' then
		characterPlayAnim('gf', getProperty('singAnimations')[math.abs(dir)+1], true)
		setProperty('gf.holdTimer', 0)
	end
end