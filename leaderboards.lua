-- Requires
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local widget = require "widget"
local json = require "json"
local gameNetwork = require "gameNetwork"

function scene:createScene( event )
	
	local screenGroup = self.view
	
	background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	
	
	local function postScoreSubmit( event )
		print(event)
		return true
	end

	local myScore = 100

	--for GameCenter, default to the leaderboard name from iTunes Connect
	local myCategory = "com.yourname.yourgame.highscores"

	if ( system.getInfo( "platformName" ) == "Android" ) then
   --for GPGS, reset "myCategory" to the string provided from the leaderboard setup in Google
		myCategory = "CgkIx9CShNATEAIQAQ"
	end

	gameNetwork.request( "setHighScore",
	{
		localPlayerScore = { category=myCategory, value=tonumber(myScore) },
		listener = postScoreSubmit
	} )
	
	showLeaderboards()
end

function showLeaderboards( event )
   if ( system.getInfo("platformName") == "Android" ) then
      gameNetwork.show( "leaderboards" )
   else
      gameNetwork.show( "leaderboards", { leaderboard = {timeScope="AllTime"} } )
   end
   return true
end

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


function scene:enterScene( event )
	
end

function scene:exitScene( event )

end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene