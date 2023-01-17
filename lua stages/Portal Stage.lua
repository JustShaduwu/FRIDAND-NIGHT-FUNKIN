function onCreate()
	makeLuaSprite('stageback', 'Bg/Screen_BG', -400, -250); --Estan viendo
	
	    scaleObject('stageback', 1.2,1.2);
		
	makeLuaSprite('stagefront', 'Bg/Stage1', -400, -250); --Portal
	setLuaSpriteScrollFactor('stagefront', 0.9, 0.9);
	    scaleObject('stagefront', 1.2,1.2);

	makeLuaSprite('light', 'Bg/Portal_Light', -400, -250); --Esto fue añadido un poco despues de la primera version, no podemos tener shaders rtx y covers utau, pero si un poquito de ambiente xd
	    scaleObject('light', 1.2,1.2);
		
	addLuaSprite('stageback', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('light', false);
	close(true); --Lagno
end
