function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-shadow-dead'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'shadowdeadSFX'); --put in mods/sounds/
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameovershadow'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameovershadowEnd'); --put in mods/music/
end