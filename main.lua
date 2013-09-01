local storyboard = require "storyboard"
local backgroundMusic = audio.loadStream("backgroundmusic.mp3")
local json = require "json"

audio.play(backgroundMusic, {
		channel = 1,
		loops = -1,
	})	

function saveTable(t, fileName)
    local path = system.pathForFile( fileName, system.DocumentsDirectory )
    local file = io.open( path, "w" )
    if file then
		local contents = json.encode(t)
		file:write(contents)
		io.close( file )
		return true
	else 
		return false
	end
end

function loadTable(fileName)
    local path = system.pathForFile( fileName, system.DocumentsDirectory )
    local contents = ""
	local myTable = {}
	local file = io.open( path, "r" )

    if file then
        local contents = file:read("*a")
		myTable = json.decode(contents)
        io.close( file )
        return myTable
    else
        return nil
    end
end

if loadTable("settings.json") == nil then
	local settings = {}
	settings.score = 0
	settings.highscore = 0
	settings.mute = false
	settings.medel = 0
	settings.runs = 0
	settings.medelbonus = 0
	settings.timesdead = 0
	saveTable( settings, "settings.json")
end

if loadTable( "game2settings.json" ) == nil then
	local game2settings = {}
	game2settings.score = 0
	game2settings.highscore = 0
	game2settings.medel = 0
	game2settings.runs = 0
	game2settings.timesdead = 0
	saveTable( game2settings, "game2settings.json")
end

if loadTable( "game3settings.json" ) == nil then
	local game3settings = {}
	game3settings.time = 0
	game3settings.highscoretime = 0
	game3settings.medeltime = 0
	game3settings.runs = 0
	game3settings.timesdead = 0
	saveTable( game3settings, "game3settings.json")
end

if loadTable( "achive.json") == nil then

	local achive = {}
	achive.score50 = false
	achive.score100 = false
	achive.score150 = false
	achive.score200 = false
	achive.dead5 = false
	achive.dead10 = false
	achive.dead15 = false
	achive.played50 = false
	achive.played100 = false
	achive.played200 = false
	achive.star5 = false
	achive.star10 = false
	achive.star15 = false
	achive.bonus50 = false
	achive.bonus100 = false
	achive.bonus150 = false
	achive.allachive = false
	
	saveTable( achive, "achive.json" )
end

if loadTable( "achive2.json") == nil then

	local achive2 = {}
	achive2.score50 = false
	achive2.score100 = false
	achive2.score150 = false
	achive2.score200 = false
	achive2.dead5 = false
	achive2.dead10 = false
	achive2.dead15 = false
	achive2.played50 = false
	achive2.played100 = false
	achive2.played200 = false
	achive2.star4 = false
	achive2.star7 = false
	achive2.star10 = false
	achive2.allachive = false
	
	saveTable( achive2, "achive2.json" )
end

if loadTable( "achive3.json") == nil then

	local achive3 = {}
	achive3.dead5 = false
	achive3.dead10 = false
	achive3.dead15 = false
	achive3.time30 = false
	achive3.time60 = false
	achive3.time120 = false
	achive3.played50 = false
	achive3.played100 = false
	achive3.played200 = false
	achive3.star4 = false
	achive3.star7 = false
	achive3.star10 = false
	achive3.allachive = false
	
	saveTable( achive3, "achive3.json" )
end

storyboard.gotoScene( "start" )


