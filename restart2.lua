-- Requires
local json = require "json"
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local widget = require "widget"

function scene:createScene( event )
	
	settings = loadTable( "settings.json")
	game2settings = loadTable("game2settings.json")
	mute = settings.mute
	bonusTime = game2settings.bonusTime
	
	local screenGroup = self.view
	
	background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	local titel = display.newText( "Time Attack", display.contentWidth, display.contentHeight, native.systemFont, 45 )
	titel:setReferencePoint( display.TopLeftReferencePoint )
	titel.x = display.contentWidth * 0.04
	titel.y = display.contentHeight * 0.03
	titel:setTextColor( 150, 150, 150 )
	screenGroup:insert( titel )
	
	if game2settings.newHighScore == true then
		
		local newRecordTime = display.newText("New record!", display.contentWidth, display.contentHeight, native.systemFont, 20 )
		newRecordTime:setReferencePoint( display.TopLeftReferencePoint )
		newRecordTime.x = display.contentWidth * 0.65
		newRecordTime.y = display.contentHeight * 0.45
		newRecordTime:setTextColor( 255, 0, 0 )
		screenGroup:insert( newRecordTime )
		
		game2settings.newHighScore = false
		
	end
	
	local yourTime = display.newText("Your score: " .. game2settings.score .. " points", display.contentWidth, display.contentHeight, native.systemFont, 20 )
	yourTime:setReferencePoint( display.TopLeftReferencePoint )
	yourTime.x = display.contentWidth * 0.04
	yourTime.y = display.contentHeight * 0.35
	yourTime:setTextColor( 150, 150, 150 )
	screenGroup:insert( yourTime )
	
	local yourRecordTime = display.newText("Your best score: " .. game2settings.highscore .. " points", display.contentWidth, display.contentHeight, native.systemFont, 20 )
	yourRecordTime:setReferencePoint( display.TopLeftReferencePoint )
	yourRecordTime.x = display.contentWidth * 0.04
	yourRecordTime.y = display.contentHeight * 0.45
	yourRecordTime:setTextColor( 50, 150, 150 )
	screenGroup:insert( yourRecordTime )
	
	local restartText = display.newText( "Tap on the screen to restart", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	restartText:setReferencePoint( display.TopLeftReferencePoint )
	restartText.x = display.contentWidth * 0.06
	restartText.y = display.contentHeight * 0.23
	restartText:setTextColor( 150, 150, 150 )
	screenGroup:insert( restartText )
	
	local medelText = display.newText( "Average score: " .. game2settings.medel, display.contentWidth, display.contentHeight, native.systemFont, 15 )
	medelText:setReferencePoint( display.TopLeftReferencePoint )
	medelText.x = display.contentWidth * 0.06
	medelText.y = display.contentHeight * 0.55
	medelText:setTextColor( 150, 150, 150 )
	screenGroup:insert( medelText )
	
	local playedText = display.newText( "You have played " .. game2settings.runs .. " times", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	playedText:setReferencePoint( display.TopLeftReferencePoint )
	playedText.x = display.contentWidth * 0.06
	playedText.y = display.contentHeight * 0.61
	playedText:setTextColor( 150, 150, 150 )
	screenGroup:insert( playedText )
	
	muteBtn = widget.newButton{
		overFile = "Soundon.png",
		defaultFile = "Soundon.png",
		onEvent = sound,
	}
	muteBtn:setReferencePoint( display.TopRightReferencePoint )
	muteBtn.x = display.contentWidth * 0.95
	muteBtn.y = display.contentHeight * 0.05
	muteBtn.isVisible = false
	screenGroup:insert( muteBtn )
	
	muteBtn2 = widget.newButton{
		overFile = "Soundmute.png",
		defaultFile = "Soundmute.png",
		onEvent = sound,
	}
	muteBtn2:setReferencePoint( display.TopRightReferencePoint )
	muteBtn2.x = display.contentWidth * 0.95
	muteBtn2.y = display.contentHeight * 0.05
	muteBtn2.isVisible = false
	screenGroup:insert( muteBtn2 )	
	
	if mute == true then
		muteBtn.isVisible = false
		muteBtn2.isVisible = true
	elseif mute == false then
		muteBtn.isVisible = true
		muteBtn2.isVisible = false
	end
	
	local facebookText = display.newText( "Upload a screenshot of your highscore", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	facebookText:setReferencePoint( display.TopLeftReferencePoint )
	facebookText.x = display.contentWidth * 0.04
	facebookText.y = display.contentHeight * 0.75
	facebookText:setTextColor( 50, 150, 150 )
	screenGroup:insert( facebookText )
	
	local facebookText2 = display.newText( "on our FB-group: Side-Scroller", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	facebookText2:setReferencePoint( display.TopLeftReferencePoint )
	facebookText2.x = display.contentWidth * 0.04
	facebookText2.y = display.contentHeight * 0.81
	facebookText2:setTextColor( 50, 150, 150 )
	screenGroup:insert( facebookText2 )
	
	local scoreToBeat = display.newText( "Score to beat: 130 points", display.contentWidth, display.contentHeight, native.systemFont, 20 )
	scoreToBeat:setReferencePoint( display.TopLeftReferencePoint )
	scoreToBeat.x = display.contentWidth * 0.04
	scoreToBeat.y = display.contentHeight * 0.88
	scoreToBeat:setTextColor( 255, 0, 0 )
	screenGroup:insert( scoreToBeat )
	
	local highScoreName = display.newText( "(Patrik, 2013-07-17)", display.contentWidth, display.contentHeight, native.systemFont, 12 )
	highScoreName:setReferencePoint( display.TopLeftReferencePoint )
	highScoreName.x = display.contentWidth * 0.53
	highScoreName.y = display.contentHeight * 0.9
	highScoreName:setTextColor( 255, 0, 0 )
	screenGroup:insert( highScoreName )
	
	achivementsBtn = widget.newButton{
		label = "Achivements",
		fontSize = 12,
		labelColor = { default= {255, 255, 255, 255 },
						over = { 255, 255, 255, 150 } },
		overFile = "resetbtnpressed.png",
		defaultFile = "resetbtn.png",
		onEvent = achivementsFunction,
	}
	achivementsBtn:setReferencePoint( display.TopRightReferencePoint )
	achivementsBtn.x = display.contentWidth * 0.98
	achivementsBtn.y = display.contentHeight * 0.65
	screenGroup:insert( achivementsBtn )	
	
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

function sound ( event )
	
	if event.phase == "began" then
	if mute == false then
		mute = true
		muteBtn.isVisible = false
		muteBtn2.isVisible = true
		audio.pause(0)
	else
		mute = false
		muteBtn.isVisible = true
		muteBtn2.isVisible = false
		audio.resume(0)
	end
	end
end

function start( event )
	if event.phase == "began" then
	
		storyboard.gotoScene( "start", "fade", 400 )
		
	end
end

function achivementsFunction( event )

	if event.phase == "ended" then
	
		storyboard.gotoScene( "achievements2", "fade", 400 )
		
	end
end

function scene:enterScene( event )
	
	storyboard.purgeScene("game2")
	background:addEventListener( "touch", start )
		
end

function scene:exitScene( event )

	background:removeEventListener( "touch", start )
	settings.mute = mute
	saveTable(settings, "settings.json")
	saveTable(game2settings, "game2settings.json")

end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene