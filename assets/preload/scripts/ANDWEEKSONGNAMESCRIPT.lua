font = "funkin"
function onCreate()
	makeLuaText('xd', '', 512, 10, 690)
	addLuaText('xd')
	
	setTextAlignment('xd', 'left')
	
    if songName == 'Portal' then --First song
		setTextString('xd', 'Portal - Shaduwu')
    end
    if songName == 'Alone' then --Second song
		setTextString('xd', 'Alone - Shaduwu')
    end
    if songName == 'Shadow' then --Last Song
		setTextString('xd', 'Shadow - Shaduwu ft.AlexPlus')
    end
    if songName == 'Habits' then --Freeplay Song
		setTextString('xd', 'Habits - Shaduwu')
    end
end
--ONLY FOR THE MOD, NO VANILLA!