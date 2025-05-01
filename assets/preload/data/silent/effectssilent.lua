function onCreate()
	makeAnimatedLuaSprite('rain', 'Bg/Friends/rain', 0, 0);
	setLuaSpriteScrollFactor('rain', 0.3, 0.3);
	scaleObject('rain', 1, 1);
	setObjectCamera('rain','camHud')

	makeAnimatedLuaSprite('splash', 'Bg/Friends/splash', 0, 50);

	addLuaSprite('splash', false);
	addAnimationByPrefix('splash', 'loop', 'splash loop', 15, true);
	addLuaSprite('rain', true);
	addAnimationByPrefix('rain', 'loop', 'rain loop', 15, true);
	-- philly 
	makeLuaSprite('fgb', 'Bg/Friends/darkscreen', -340, -210);
	addLuaSprite('fgb')
    scaleObject('fgb', 2.2,2.2); -- scale front
	
--	makeLuaSprite('portalandgeminiyolocolors', 'Bg/Friends/window', -400, -250)
--	scaleObject('portalandgeminiyolocolors', 1.2,1.2); -- scale front
--	setScrollFactor('portalandgeminiyolocolors', 0.9, 0.9)
--	addLuaSprite('portalandgeminiyolocolors')
	
doTweenAlpha('rain','rain',0, 0.1,'linear')
doTweenAlpha('splash','splash',0, 0.1,'linear')
-- doTweenAlpha('portalandgeminiyolocolors','portalandgeminiyolocolors',0, 0.1,'linear')
doTweenAlpha('fgb','fgb',0, 0.1,'linear')
end

function onUpdatePost()
if curBeat == 107 then --change curBeat to whatever
doTweenAlpha('rain','rain',1, 2,'linear')
doTweenAlpha('splash','splash',1, 2,'linear')
-- doTweenAlpha('portalandgeminiyolocolors','portalandgeminiyolocolors',1, 2,'linear')
doTweenAlpha('fgb','fgb',1, 2,'linear')
end
if curBeat == 172 then --change curBeat to whatever
doTweenAlpha('rain','rain',0, 0.1,'linear')
doTweenAlpha('splash','splash',0, 0.1,'linear')
-- doTweenAlpha('portalandgeminiyolocolors','portalandgeminiyolocolors',0, 0.1,'linear')
doTweenAlpha('fgb','fgb',0, 0.1,'linear')
end
if curBeat == 235 then --change curBeat to whatever
doTweenAlpha('rain','rain',1, 2,'linear')
doTweenAlpha('splash','splash',1, 2,'linear')
doTweenAlpha('portalandgeminiyolocolors','portalandgeminiyolocolors',1, 2,'linear')
doTweenAlpha('fgb','fgb',1, 2,'linear')
end
if curBeat == 299 then --change curBeat to whatever
doTweenAlpha('rain','rain',0, 0.1,'linear')
doTweenAlpha('splash','splash',0, 0.1,'linear')
doTweenAlpha('portalandgeminiyolocolors','portalandgeminiyolocolors',0, 0.1,'linear')
doTweenAlpha('fgb','fgb',0, 0.1,'linear')
end
end