-- Requires
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local widget = require "widget"
local json = require "json"

function scene:createScene( event )
	
	settings = loadTable("settings.json")
	
	mute = settings.mute
	
	if mute == true then
		audio.pause(1)
	end
	
	local screenGroup = self.view
	
	local background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	local scrollImg1 = display.newImage( "scrollimg4.png" )
	scrollImg1.x = 240
	scrollImg1.speed = 3
	screenGroup:insert( scrollImg1 )
	
	local scrollImg2 = display.newImage( "scrollimg3.png" )
	scrollImg2.x = 240
	scrollImg2.speed = 5
	screenGroup:insert( scrollImg2 )
	
	local titel = display.newText( "Side-Scroller", display.contentWidth, display.contentHeight, native.systemFont, 50 )
	titel:setReferencePoint( display.CenterReferencePoint )
	titel.x = display.contentWidth * 0.5
	titel.y = display.contentHeight * 0.15
	titel:setTextColor( 150, 150, 150 )
	screenGroup:insert( titel )
	
	
	local startText = display.newText( "Pick a game mode to play", display.contentWidth, display.contentHeight, native.systemFont, 20 )
	startText:setReferencePoint( display.CenterReferencePoint )
	startText.x = display.contentWidth * 0.5
	startText.y = display.contentHeight * 0.3
	startText:setTextColor( 150, 150, 150 )
	screenGroup:insert( startText )
	
	
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
	
	gameOneBtn = widget.newButton{
		label = "Classic",
		fontSize = 17,
		labelColor = { default= {255, 255, 255, 255 },
					over = { 255, 255, 255, 150 } },
		overFile = "menubtnpressed.png",
		defaultFile = "menubtn.png",
		onEvent = gameOne,
	}
	gameOneBtn:setReferencePoint( display.TopRightReferencePoint )
	gameOneBtn.x = display.contentWidth * 0.35
	gameOneBtn.y = display.contentHeight * 0.5
	screenGroup:insert( gameOneBtn )
	
	gameTwoBtn = widget.newButton{
		label = "Time Attack",
		fontSize = 17,
		labelColor = { default= {255, 255, 255, 255 },
						over = { 255, 255, 255, 150 } },
		overFile = "menubtnpressed.png",
		defaultFile = "menubtn.png",
		onEvent = gameTwo,
	}
	gameTwoBtn:setReferencePoint( display.TopRightReferencePoint )
	gameTwoBtn.x = display.contentWidth * 0.6
	gameTwoBtn.y = display.contentHeight * 0.5
	screenGroup:insert( gameTwoBtn )
	
	gameThreeBtn = widget.newButton{
		label = "Survival",
		fontSize = 17,
		labelColor = { default= {255, 255, 255, 255 },
						over = { 255, 255, 255, 150 } },
		overFile = "menubtnpressed.png",
		defaultFile = "menubtn.png",
		onEvent = gameThree,
	}
	gameThreeBtn:setReferencePoint( display.TopRightReferencePoint )
	gameThreeBtn.x = display.contentWidth * 0.85
	gameThreeBtn.y = display.contentHeight * 0.5
	screenGroup:insert( gameThreeBtn )
	
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

function gameOne( event )
	
	if event.phase == "ended" then
		storyboard.gotoScene( "startgame1", "fade", 400 )
	end
	
end

function gameTwo( event )
	
	if event.phase == "ended" then
		storyboard.gotoScene( "startgame2", "fade", 400 )
	end
	
end

function gameThree( event )

		if event.phase == "ended" then
			storyboard.gotoScene( "startgame3", "fade", 400 )
		end
	
end


function scene:enterScene( event )
	
	storyboard.removeScene("restart")
	storyboard.removeScene("restart2")
	storyboard.removeScene("restart3")
	storyboard.removeScene("achievements")
	storyboard.removeScene("achievements2")
	storyboard.removeScene("achievements3")
	storyboard.removeScene("game")
	storyboard.removeScene("game2")
	storyboard.removeScene("game3")
	storyboard.removeScene("startgame1")
	storyboard.removeScene("startgame2")
	storyboard.removeScene("startgame3")
	
end

function scene:exitScene( event )

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