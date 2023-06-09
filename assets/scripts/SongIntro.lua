--easy script configs
IntroTextSize = 25	--Size of the text for the Now Playing thing.
IntroSubTextSize = 30 --size of the text for the Song Name.
IntroTagColor = '8300c3'	--Color of the tag at the end of the box.
IntroTagWidth = 15	--Width of the box's tag thingy.
--easy script configs

--actual script
function onCreate()
	--the tag at the end of the box

	--the box, esta cosa es fea, y obsoleta,  mejor, inspiremonos un poco de las dokis, y hagamos nuestro propio, now playing
	-- makeLuaSprite('JukeBox', 'empty', -305-IntroTagWidth, 15)
	-- makeGraphic('JukeBox', 300, 100, '000000')
	-- setObjectCamera('JukeBox', 'other')
	-- addLuaSprite('JukeBox', true)
	
	--the text for the "Now Playing" bit
    if songName == 'Alone' then --Second song
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxText', 'Shaduwu', 300, -305-IntroTagWidth, 60)
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
    makeLuaSprite('icon', 'introicons/and-og', -1000-IntroTagWidth, 30)
	setObjectCamera('icon', 'other')
	setObjectOrder('icon', 900)
	addLuaSprite('icon', true)
	end
	
    if songName == 'Portal' then --Primera Cancion
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxText', 'Shaduwu', 300, -305-IntroTagWidth, 60)
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
    makeLuaSprite('icon', 'introicons/and-og', -1000-IntroTagWidth, 30)
	setObjectCamera('icon', 'other')
	setObjectOrder('icon', 900)
	addLuaSprite('icon', true)
	end
	
    if songName == 'Habits' then --Freeplay
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxText', 'Shaduwu', 300, -305-IntroTagWidth, 60)
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
    makeLuaSprite('icon', 'introicons/and-og', -1000-IntroTagWidth, 30)
	setObjectCamera('icon', 'other')
	setObjectOrder('icon', 900)
	addLuaSprite('icon', true)
	end

    if songName == 'Tutorial Remix' then --BEEP
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxText', 'Shaduwu', 300, -305-IntroTagWidth, 60)
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
	makeLuaSprite('icon', 'introicons/gf-extend', -1000-IntroTagWidth, 30)
	setObjectCamera('icon', 'other')
	setObjectOrder('icon', 900)
	addLuaSprite('icon', true)
	end
	
    if songName == 'Andstranomical Countdown' then --COUNTDOWN
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxText', 'Shaduwu', 300, -305-IntroTagWidth, 90)
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
	makeLuaSprite('icon', 'introicons/and-og-extend', -1000-IntroTagWidth, 30)
	setObjectCamera('icon', 'other')
	setObjectOrder('icon', 900)
	addLuaSprite('icon', true)
	end

    if songName == 'Shadow' then --Shadow
	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
    addLuaText('JukeBoxSubText')
	makeLuaText('JukeBoxText', 'AlexPlus801    Shaduwu', 300, -305-IntroTagWidth, 60) -- Add Alex Credits!!
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
    makeLuaSprite('icon', 'introicons/shadow-and-og-extend', -1000-IntroTagWidth, 30)
	setObjectCamera('icon', 'other')
	setObjectOrder('icon', 900)
	addLuaSprite('icon', true)
	end
	
	-- if no song name, pus no aparece nada
--	makeLuaText('JukeBoxSubText', songName, 300, -305-IntroTagWidth, 30)
--	setTextAlignment('JukeBoxSubText', 'left')
--	setObjectCamera('JukeBoxSubText', 'other')
--	setTextSize('JukeBoxSubText', IntroSubTextSize)
--  addLuaText('JukeBoxSubText')

end

--motion functions
function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenX('MoveInOne', 'icon', 0, 1, 'CircInOut')
	doTweenX('MoveInTwo', 'JukeBox', 0, 1, 'CircInOut')
	doTweenX('MoveInThree', 'JukeBoxText', 0, 1, 'CircInOut')
	doTweenX('MoveInFour', 'JukeBoxSubText', 0, 1, 'CircInOut')
	
	runTimer('JukeBoxWait', 3, 1)
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == 'JukeBoxWait' then
		doTweenX('MoveOutOne', 'icon', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutTwo', 'JukeBox', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutThree', 'JukeBoxText', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutFour', 'JukeBoxSubText', -450, 1.5, 'CircInOut')
	end
end
--FOR NOW PLAYING WINDOWS