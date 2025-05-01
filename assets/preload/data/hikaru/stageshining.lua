function onCreate()
	makeLuaSprite('text', 'Bg/Friends/hikarutext', 15, 477);
	setObjectCamera('text','camHud')
--	scaleObject('text', 2, -5); -- scale front
	
	makeLuaSprite('star1', 'Bg/Friends/YuriSparkleBG', 0, 0);
	setObjectCamera('star1','camHud')
	setLuaSpriteScrollFactor('star1', 2, 0.9); --front anim
	scaleObject('star1', 1.2,1.2); -- scale front

	makeLuaSprite('star2', 'Bg/Friends/YuriSparkleFG', -1270, 0);
	setObjectCamera('star2','camHud')
    scaleObject('star2', 1.2,1.2); -- scale front

	makeLuaSprite('star3', 'Bg/Friends/YuriSparkleFG', 0, 0);
	setObjectCamera('star3','camHud')
    scaleObject('star3', 1.2,1.2); -- scale front
	
	makeLuaSprite('rosa', 'Bg/Friends/vignette', -200, -200);
    scaleObject('rosa', 2.2,2.2); -- scale front

	addLuaSprite('text', true)
	addLuaSprite('rosa', false);	
	addLuaSprite('star1', true);
	addLuaSprite('star2', true);
	addLuaSprite('star3', true);
doTweenAlpha('rosa','rosa',0, 0.1,'linear')
doTweenAlpha('star1','star1',0, 0.1,'linear')
doTweenAlpha('star2','star2',0, 0.1,'linear')
doTweenAlpha('star3','star3',0, 0.1,'linear')
doTweenAlpha('text','text',0, 0.1,'linear')
end
function onUpdatePost()
if curBeat == 262 then --change curBeat to whatever
    doTweenAlpha('rosa','rosa',1, 2,'linear')
	doTweenAlpha('star1','star1',1, 2,'linear')
	doTweenAlpha('star2','star2',1, 2,'linear')
	doTweenAlpha('star3','star3',1, 2,'linear')
    doTweenAlpha('text','text',1, 4,'linear')
end
if curBeat == 263 then --change curBeat to whatever
		doTweenX('star1','star1', -1280, 80.0,'linear')
		doTweenX('star2','star2', 1270, 80.0,'linear')
		doTweenX('star3','star3', -1280, 150.0,'linear')
end
if curBeat == 293 then --change curBeat to whatever
    doTweenAlpha('rosa','rosa',0, 2,'linear')
	doTweenAlpha('star1','star1',0, 2,'linear')
	doTweenAlpha('star2','star2',0, 2,'linear')
	doTweenAlpha('star3','star3',0, 2,'linear')
	doTweenAlpha('text','text', 0, 4,'linear')
end
end