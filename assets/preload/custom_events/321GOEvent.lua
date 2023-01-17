-- Made by HafimieForever/Hafimie, please credit me if you want to use these codes in another project, I would really appreciate it ;)

function onEvent(name, value1, value2)
	if name == "321GOEvent" then
	   runTimer('wait', 0.90);
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'wait' then
		makeLuaSprite('ready', 'ready', 250, 160);
		addLuaSprite('ready', true);
		setObjectCamera('ready', 'other');
		doTweenAlpha('readyBye', 'ready', 0, 0.40, 'linear')
	else
		print('No completed timer.')
	end
end

function onTweenCompleted(tag)
	if tag == 'readyBye' then
		makeLuaSprite('set', 'set', 250, 160);
		addLuaSprite('set', true);
		setObjectCamera('set', 'other');
		doTweenAlpha('setBye', 'set', 0, 0.40, 'linear')
	elseif tag == 'setBye' then
		makeLuaSprite('go', 'go', 330, 100);
		addLuaSprite('go', true);
		setObjectCamera('go', 'other');
		doTweenAlpha('goBye', 'go', 0, 0.40, 'linear')
	else
		print('No completed tween.')
    end
end