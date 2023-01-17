
bob = 0

function onCreate() --CINIMATIC SCRIPT

setPropertyFromClass('flixel.FlxG','sound.music.volume',0)
setProperty('skipCountdown',true)
setProperty('cpuControlled',true)
setProperty('camHUD.visible',true)
setProperty('cpuControlled', true)

end


function onStartCountdown()

runTimer('songg',1)
if bob == 0 then
bob = 1
return Function_Stop;
end

end


function onTimerCompleted(t,l,ll)

if t == 'songg' then

startCountdown()
end

end