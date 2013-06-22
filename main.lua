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

if loadTable( "achive.json") == nil then

	local achive = {}
	achive.score50 = false
	achive.score100 = false
	achive.score150 = false
	achive.score200 = false
	achive.dead5 = false
	achive.dead10 = false
	achive.dead15 = false
	achive.time30 = false
	achive.time40 = false
	achive.time50 = false
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

storyboard.gotoScene( "start" )


