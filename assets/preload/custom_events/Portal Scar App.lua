-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Portal Scar App' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('scar.alpha', targetAlpha);
		else
			doTweenAlpha('scarFadeEventTween', 'scar', targetAlpha, duration, 'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end