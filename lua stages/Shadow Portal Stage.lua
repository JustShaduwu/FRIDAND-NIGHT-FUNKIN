function onCreate()
	makeLuaSprite('stage', 'Bg/ShadowFuse', -400, -250); --Bug con las capas, no importa xd
	    scaleObject('stage', 1.2,1.2); --Tamaño Funky
		
	makeLuaSprite('light', 'Bg/Shadow_Portal_Light', -400, -250); --Luz bonita
	    scaleObject('light', 1.2,1.2); --Apropiada

	addLuaSprite('stage', false); --Nunca le entendi a esto u,.u
	addLuaSprite('light', false); --MEnos
	close(true); --Menos Lag pls
end