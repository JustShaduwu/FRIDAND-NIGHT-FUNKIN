--Quick explanation P3 is for player's ally icon and P4 is for being the opponent's ally below there are other modes of this script if you only want a third icon
--Just write the path of your icons make sure the resolution of them are 300*150 in the future i will prob add wininng icons support :p
P3 = "icons/icon-bf"
P4 = "icons/icon-sofia-og" 
P5 = "icons/icon-yolo-og"
P6 = "icons/icon-miguel-og"  
P7 = "icons/icon-dayami-og" 
P3P = false 
--Set on true when you want only P3 being the enemy and there isn't a character which takes the place of P4
P3E = false
--Set on true when you want only a P3 being the player's ally and there isn't a character which takes the place of P4
--By default it will bring both icons so let them on false to bring P3 and P4 icons so plz don't set both as true .-.

function onCreatePost() --Made by me Aldoidk04 :33333
if P3E then
P4 = P3
icon1()
icon2()
icon3()
icon4()
icon5()
elseif P3P then
icon1()
icon2()
icon3()
icon4()
icon5()
else
icon1()
icon2()
icon3()
icon4()
icon5()
end
setProperty('iconP3.alpha', 0)
setProperty('iconP4.alpha', 0)
setProperty('iconP5.alpha', 0)
setProperty('iconP6.alpha', 0)
setProperty('iconP7.alpha', 0)
end
--The rest is just the logic of the script :p sorry if is a big mess
--If you have a custom healthbar or something i think you should look at these lines (20,21 and 38,39)and set true to false
function icon1()
makeLuaSprite('iconP3',nil,0,0)
loadGraphic('iconP3', P3, 150)
addLuaSprite('iconP3',true)
setProperty("iconP3.flipX", true)
setObjectCamera('iconP3', "hud")
end

function icon2()
makeLuaSprite('iconP4',nil,0,0)
loadGraphic('iconP4', P4, 150)
addLuaSprite('iconP4',true)
setObjectCamera('iconP4', "hud")
end

function icon3()
makeLuaSprite('iconP5',nil,0,0)
loadGraphic('iconP5', P5, 150)
addLuaSprite('iconP5',true)
setObjectCamera('iconP5', "hud")
end

function icon4()
makeLuaSprite('iconP6',nil,0,0)
loadGraphic('iconP6', P6, 150)
addLuaSprite('iconP6',true)
setObjectCamera('iconP6', "hud")
end

function icon5()
makeLuaSprite('iconP7',nil,0,0)
loadGraphic('iconP7', P7, 150)
addLuaSprite('iconP7',true)
setObjectCamera('iconP7', "hud")
end

function onUpdatePost()
h = getProperty('health')
--Oh yeah if you want them with the same alpha from the actual icons just remove the 2 lines lol
--setProperty('iconP3.alpha',getProperty('iconP1.alpha'))
--setProperty('iconP4.alpha',getProperty('iconP2.alpha'))
setProperty('iconP3.angle',getProperty('iconP1.angle'))
setProperty('iconP4.angle',getProperty('iconP2.angle'))
setProperty('iconP3.x',getProperty('iconP1.x')+60)
setProperty('iconP4.x',getProperty('iconP2.x')-60)
setProperty('iconP3.y',getProperty('iconP1.y')-20)
setProperty('iconP4.y',getProperty('iconP2.y')-20)

setProperty('iconP5.angle',getProperty('iconP2.angle'))
setProperty('iconP6.angle',getProperty('iconP2.angle'))
setProperty('iconP5.x',getProperty('iconP2.x')-120)
setProperty('iconP6.x',getProperty('iconP2.x')-180)
setProperty('iconP5.y',getProperty('iconP2.y')-20)
setProperty('iconP6.y',getProperty('iconP2.y')-40)

setProperty('iconP7.angle',getProperty('iconP2.angle'))
setProperty('iconP7.x',getProperty('iconP2.x')-240)
setProperty('iconP7.y',getProperty('iconP2.y')-20)

--If you want to make them smaller i would recommend you to just write -0.1
setProperty('iconP3.scale.x', getProperty('iconP1.scale.x'))
	setProperty('iconP3.scale.y', getProperty('iconP1.scale.y'))
setProperty('iconP4.scale.x', getProperty('iconP2.scale.x'))
	setProperty('iconP4.scale.y', getProperty('iconP2.scale.y'))
if downscroll then
setProperty('iconP3.y',getProperty('iconP1.y')+20)
setProperty('iconP4.y',getProperty('iconP2.y')+20)
end
if h < 0.4 then --When you are losing
loadGraphic('iconP3', P3, 150)
addAnimation('iconP3', P3, {1, 0}, 0, true)
loadGraphic('iconP4', P4, 150)
addAnimation('iconP4', P4, {2, 0}, 0, true)
loadGraphic('iconP5', P5, 150)
addAnimation('iconP5', P5, {2, 0}, 0, true)
loadGraphic('iconP6', P6, 150)
addAnimation('iconP6', P6, {2, 0}, 0, true)
loadGraphic('iconP7', P7, 150)
addAnimation('iconP7', P7, {2, 0}, 0, true)
elseif h > 1.6 then --When you are winning .-.
loadGraphic('iconP4', P4, 150)
addAnimation('iconP4', P4, {1, 0}, 0, true)
loadGraphic('iconP5', P5, 150)
addAnimation('iconP5', P5, {1, 0}, 0, true)
loadGraphic('iconP6', P6, 150)
addAnimation('iconP6', P6, {1, 0}, 0, true)
loadGraphic('iconP7', P7, 150)
addAnimation('iconP7', P7, {1, 0}, 0, true)
loadGraphic('iconP3', P3, 150)
addAnimation('iconP3', P3, {2, 0}, 0, true)
else --Normal
loadGraphic('iconP4', P4, 150)
loadGraphic('iconP3', P3, 150)
addAnimation('iconP3', P3, {0, 1}, 0, true)
addAnimation('iconP4', P4, {0, 1}, 0, true)
loadGraphic('iconP5', P5, 150)
addAnimation('iconP5', P5, {0, 1}, 0, true)
loadGraphic('iconP6', P6, 150)
addAnimation('iconP6', P6, {0, 1}, 0, true)
loadGraphic('iconP7', P7, 150)
addAnimation('iconP7', P7, {0, 1}, 0, true)
end
end

function onBeatHit()
	if curBeat % 544 == 0 then
setProperty('iconP4.alpha', 1)
setProperty('iconP5.alpha', 1)
setProperty('iconP6.alpha', 1)
setProperty('iconP7.alpha', 1)
	end
	if curBeat % 576 == 0 then
setProperty('iconP4.alpha', 0)
setProperty('iconP5.alpha', 0)
setProperty('iconP6.alpha', 0)
setProperty('iconP7.alpha', 0)
	end
	if curBeat % 608 == 0 then
setProperty('iconP4.alpha', 1)
	end
end