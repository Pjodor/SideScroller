-- Requires
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local widget = require "widget"
local json = require "json"

function scene:createScene( event )
	
	settings = loadTable("settings.json")
	game3settings = loadTable("game3settings.json")
	local timeRecord = game3settings.highscoretime
	mute = settings.mute
	
	if mute == true then
		audio.pause(1)
	end
	
	local screenGroup = self.view
	
	background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	local titel = display.newText( "Survival", display.contentWidth, display.contentHeight, native.systemFont, 50 )
	titel:setReferencePoint( display.TopLeftReferencePoint )
	titel.x = display.contentWidth * 0.04
	titel.y = display.contentHeight * 0.03
	titel:setTextColor( 150, 150, 150 )
	screenGroup:insert( titel )
	
	local startText = display.newText( "Tap on the screen to start", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	startText:setReferencePoint( display.TopLeftReferencePoint )
	startText.x = display.contentWidth * 0.05
	startText.y = display.contentHeight * 0.25
	startText:setTextColor( 150, 150, 150 )
	screenGroup:insert( startText )
	
	local infoText = display.newText( "Stay alive as long as you can, time", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	infoText:setReferencePoint( display.TopLeftReferencePoint )
	infoText.x = display.contentWidth * 0.08
	infoText.y = display.contentHeight * 0.44
	infoText:setTextColor( 150, 150, 150 )
	screenGroup:insert( infoText )
	
	local infoText2 = display.newText( "runs out if you don't take stars!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	infoText2:setReferencePoint( display.TopLeftReferencePoint )
	infoText2.x = display.contentWidth * 0.08
	infoText2.y = display.contentHeight * 0.51
	infoText2:setTextColor( 150, 150, 150 )
	screenGroup:insert( infoText2 )
	
	local yourRecordTime = display.newText("Your best time: " .. timeRecord .. " seconds", display.contentWidth, display.contentHeight, native.systemFont, 30 )
	yourRecordTime:setReferencePoint( display.TopLeftReferencePoint )
	yourRecordTime.x = display.contentWidth * 0.05
	yourRecordTime.y = display.contentHeight * 0.7
	yourRecordTime:setTextColor( 50, 150, 150 )
	screenGroup:insert( yourRecordTime )
	
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
	
	local scoreToBeat = display.newText("Time to beat: 35 seconds", display.contentWidth, display.contentHeight, native.systemFont, 25 )
	scoreToBeat:setReferencePoint( display.TopLeftReferencePoint )
	scoreToBeat.x = display.contentWidth * 0.05
	scoreToBeat.y = display.contentHeight * 0.84
	scoreToBeat:setTextColor( 255, 0, 0 )
	screenGroup:insert( scoreToBeat )
	
	local highScoreName = display.newText( "(Patrik, 2013-07-18)", display.contentWidth, display.contentHeight, native.systemFont, 12 )
	highScoreName:setReferencePoint( display.TopLeftReferencePoint )
	highScoreName.x = display.contentWidth * 0.65
	highScoreName.y = display.contentHeight * 0.875
	highScoreName:setTextColor( 255, 0, 0 )
	screenGroup:insert( highScoreName )
	
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
	
		storyboard.gotoScene( "game3", "fade", 400 )
		
	end
end

function scene:enterScene( event )
	
	background:addEventListener( "touch", start )
	
end

function scene:exitScene( event )

	background:removeEventListener( "touch", start )
	settings.mute = mute
	saveTable(settings,"settings.json")
	
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene