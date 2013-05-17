-- Requires
local json = require "json"
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local widget = require "widget"

function scene:createScene( event )
	
	settings = loadTable("settings.json")
	mute = settings.mute
	bonusTime = settings.bonusTime
	
	local screenGroup = self.view
	
	background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	local titel = display.newText( "Side-Scroller", display.contentWidth, display.contentHeight, native.systemFont, 45 )
	titel:setReferencePoint( display.TopLeftReferencePoint )
	titel.x = display.contentWidth * 0.04
	titel.y = display.contentHeight * 0.03
	titel:setTextColor( 150, 150, 150 )
	screenGroup:insert( titel )
	
	if settings.score > settings.highscore then
		settings.highscore = settings.score
		
		local newRecordTime = display.newText("New record!", display.contentWidth, display.contentHeight, native.systemFont, 25 )
		newRecordTime:setReferencePoint( display.TopLeftReferencePoint )
		newRecordTime.x = display.contentWidth * 0.05
		newRecordTime.y = display.contentHeight * 0.82
		newRecordTime:setTextColor( 255, 0, 0 )
		screenGroup:insert( newRecordTime )
	end
	
	local yourTime = display.newText("Your total score: " .. settings.score .. " points (".. bonusTime .. " bonus points)", display.contentWidth, display.contentHeight, native.systemFont, 20 )
	yourTime:setReferencePoint( display.TopLeftReferencePoint )
	yourTime.x = display.contentWidth * 0.04
	yourTime.y = display.contentHeight * 0.55
	yourTime:setTextColor( 150, 150, 150 )
	screenGroup:insert( yourTime )
	
	local yourRecordTime = display.newText("Best score: " .. settings.highscore .. " points", display.contentWidth, display.contentHeight, native.systemFont, 20 )
	yourRecordTime:setReferencePoint( display.TopLeftReferencePoint )
	yourRecordTime.x = display.contentWidth * 0.05
	yourRecordTime.y = display.contentHeight * 0.7
	yourRecordTime:setTextColor( 50, 150, 150 )
	screenGroup:insert( yourRecordTime )
	
	local restartText = display.newText( "Tap on the screen to restart", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	restartText:setReferencePoint( display.TopLeftReferencePoint )
	restartText.x = display.contentWidth * 0.06
	restartText.y = display.contentHeight * 0.25
	restartText:setTextColor( 150, 150, 150 )
	screenGroup:insert( restartText )
	
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
	
	resetBtn = widget.newButton{
		label = "Reset Score",
		labelColor = { default= {255, 255, 255, 255 },
						over = { 255, 255, 255, 150 } },
		overFile = "resetbtn.png",
		defaultFile = "resetbtn.png",
		onEvent = resetScore,
	}
	resetBtn:setReferencePoint( display.TopRightReferencePoint )
	resetBtn.x = display.contentWidth * 0.98
	resetBtn.y = display.contentHeight * 0.85
	resetBtn.isVisible = true
	screenGroup:insert( resetBtn )	
	
	if mute == true then
		muteBtn.isVisible = false
		muteBtn2.isVisible = true
	elseif mute == false then
		muteBtn.isVisible = true
		muteBtn2.isVisible = false
	end
	
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

function resetScore()
	settings.highscore = 0
end

function start( event )
	if event.phase == "began" then
	
		storyboard.gotoScene( "game", "fade", 400 )
		
	end
end

function scene:enterScene( event )
	
	storyboard.purgeScene( "game" )
	background:addEventListener( "touch", start )
		
end

function scene:exitScene( event )

	background:removeEventListener( "touch", start )
	settings.mute = mute
	saveTable(settings, "settings.json")
	
end

function scene:destroyScene( event )


end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene