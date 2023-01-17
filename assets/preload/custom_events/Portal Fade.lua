-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Portal Fade' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('stageback.alpha', targetAlpha);
			setProperty('stagefront.alpha', targetAlpha);
		    setProperty('light.alpha', targetAlpha);
		else
			doTweenAlpha('stagebackFadeEventTween', 'stageback', targetAlpha, duration, 'linear');
			doTweenAlpha('stagefrontFadeEventTween', 'stagefront', targetAlpha, duration, 'linear');
			doTweenAlpha('lightFadeEventTween', 'light', targetAlpha, duration, 'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end