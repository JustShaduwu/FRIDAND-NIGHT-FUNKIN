function onCountdownTick(swagCounter)
	if swagCounter == 0 then
        triggerEvent('Play Animation', 'countdown3', 'gf')
	end
	if swagCounter == 1 then
        triggerEvent('Play Animation', 'countdown2', 'gf')
	end
	if swagCounter == 2 then
        triggerEvent('Play Animation', 'countdown1', 'gf')
	end
	if swagCounter == 3 then
        triggerEvent('Play Animation', 'cheer', 'gf')
        triggerEvent('Play Animation', 'hey', 'bf')
	end
end
--FOR COUNTDOWN ANIMATION