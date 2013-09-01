-- Requires
local storyboard = require "storyboard"
local scene = storyboard.newScene()
local widget = require "widget"
local json = require "json"

function scene:createScene( event )
	
	achive2 = loadTable("achive2.json")
	settings = loadTable("settings.json")
	local timeRecord = settings.highscore
	mute = settings.mute
	
	if mute == true then
		audio.pause(1)
	end
	
	local screenGroup = self.view
	
	background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	local titel = display.newText( "Achievements", display.contentWidth, display.contentHeight, native.systemFont, 50 )
	titel:setReferencePoint( display.TopLeftReferencePoint )
	titel.x = display.contentWidth * 0.04
	titel.y = display.contentHeight * 0.03
	titel:setTextColor( 150, 150, 150 )
	screenGroup:insert( titel )
	
	local achivementsText = display.newText( "Game Mode: Time Attack", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	achivementsText:setReferencePoint( display.TopLeftReferencePoint )
	achivementsText.x = display.contentWidth * 0.05
	achivementsText.y = display.contentHeight * 0.22
	achivementsText:setTextColor( 150, 150, 150 )
	screenGroup:insert( achivementsText )
	
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
	
	local totalScore = display.newText( "Total score:", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	totalScore:setReferencePoint( display.TopLeftReferencePoint )
	totalScore.x = display.contentWidth * 0.05
	totalScore.y = display.contentHeight * 0.3
	totalScore:setTextColor( 150, 150, 150 )
	screenGroup:insert( totalScore )
	
	local score50 = display.newText( "50", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	score50:setReferencePoint( display.TopLeftReferencePoint )
	score50.x = display.contentWidth * 0.3
	score50.y = display.contentHeight * 0.3
	
	if achive2.score50 == true then
		score50:setTextColor( 0, 255, 0 )
	else
		score50:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( score50 )
	
	local score100 = display.newText( "100", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	score100:setReferencePoint( display.TopLeftReferencePoint )
	score100.x = display.contentWidth * 0.4
	score100.y = display.contentHeight * 0.3
	
	if achive2.score100 == true then
		score100:setTextColor( 0, 255, 0 )
	else
		score100:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( score100 )
	
	local score150 = display.newText( "150", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	score150:setReferencePoint( display.TopLeftReferencePoint )
	score150.x = display.contentWidth * 0.52
	score150.y = display.contentHeight * 0.3
	
	if achive2.score150 == true then
		score150:setTextColor( 0, 255, 0 )
	else
		score150:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( score150 )
	
	local score200 = display.newText( "200", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	score200:setReferencePoint( display.TopLeftReferencePoint )
	score200.x = display.contentWidth * 0.65
	score200.y = display.contentHeight * 0.3
	
	if achive2.score200 == true then
		score200:setTextColor( 0, 255, 0 )
	else
		score200:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( score200 )
	
	if achive2.score50 == true and achive2.score100 == true and achive2.score150 == true and achive2.score200 == true then
		local allScoreAchive = display.newText( "All done!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
		allScoreAchive:setReferencePoint( display.TopLeftReferencePoint )
		allScoreAchive.x = display.contentWidth * 0.77
		allScoreAchive.y = display.contentHeight * 0.3
		allScoreAchive:setTextColor( 0, 255, 0 )
		screenGroup:insert( allScoreAchive )
	end
	
	local starAchive = display.newText( "Stars taken:", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	starAchive:setReferencePoint( display.TopLeftReferencePoint )
	starAchive.x = display.contentWidth * 0.05
	starAchive.y = display.contentHeight * 0.36
	starAchive:setTextColor( 150, 150, 150 )
	screenGroup:insert( starAchive )
	
	local star4 = display.newText( "4", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	star4:setReferencePoint( display.TopLeftReferencePoint )
	star4.x = display.contentWidth * 0.3
	star4.y = display.contentHeight * 0.36
	
	if achive2.star4 == true then
		star4:setTextColor( 0, 255, 0 )
	else
		star4:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( star4 )
	
	local star7 = display.newText( "6", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	star7:setReferencePoint( display.TopLeftReferencePoint )
	star7.x = display.contentWidth * 0.4
	star7.y = display.contentHeight * 0.36
	
	if achive2.star7 == true then
		star7:setTextColor( 0, 255, 0 )
	else
		star7:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( star7 )
	
	local star10 = display.newText( "8", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	star10:setReferencePoint( display.TopLeftReferencePoint )
	star10.x = display.contentWidth * 0.52
	star10.y = display.contentHeight * 0.36
	
	if achive2.star10 == true then
		star10:setTextColor( 0, 255, 0 )
	else
		star10:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( star10 )
	
	if achive2.star4 == true and achive2.star7 == true and achive2.star10 == true then
		local allStarsAchive = display.newText( "All done!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
		allStarsAchive:setReferencePoint( display.TopLeftReferencePoint )
		allStarsAchive.x = display.contentWidth * 0.77
		allStarsAchive.y = display.contentHeight * 0.36
		allStarsAchive:setTextColor( 0, 255, 0 )
		screenGroup:insert( allStarsAchive )
	end
	
	local timesPlayedAchive = display.newText( "Times played:", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	timesPlayedAchive:setReferencePoint( display.TopLeftReferencePoint )
	timesPlayedAchive.x = display.contentWidth * 0.05
	timesPlayedAchive.y = display.contentHeight * 0.42
	timesPlayedAchive:setTextColor( 150, 150, 150 )
	screenGroup:insert( timesPlayedAchive )
	
	local played50 = display.newText( "50", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	played50:setReferencePoint( display.TopLeftReferencePoint )
	played50.x = display.contentWidth * 0.3
	played50.y = display.contentHeight * 0.42
	
	if achive2.played50 == true then
		played50:setTextColor( 0, 255, 0 )
	else
		played50:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( played50 )
	
	local played100 = display.newText( "100", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	played100:setReferencePoint( display.TopLeftReferencePoint )
	played100.x = display.contentWidth * 0.4
	played100.y = display.contentHeight * 0.42
	
	if achive2.played100 == true then
		played100:setTextColor( 0, 255, 0 )
	else
		played100:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( played100 )
	
	local played200 = display.newText( "200", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	played200:setReferencePoint( display.TopLeftReferencePoint )
	played200.x = display.contentWidth * 0.52
	played200.y = display.contentHeight * 0.42
	
	if achive2.played200 == true then
		played200:setTextColor( 0, 255, 0 )
	else
		played200:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( played200 )
	
	if achive2.played50 == true and achive2.played100 == true and achive2.played200 == true then
		local allplayedAchive = display.newText( "All done!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
		allplayedAchive:setReferencePoint( display.TopLeftReferencePoint )
		allplayedAchive.x = display.contentWidth * 0.77
		allplayedAchive.y = display.contentHeight * 0.42
		allplayedAchive:setTextColor( 0, 255, 0 )
		screenGroup:insert( allplayedAchive )
	end
	
	local timesDeadAchive = display.newText( "Dead before 15s:", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	timesDeadAchive:setReferencePoint( display.TopLeftReferencePoint )
	timesDeadAchive.x = display.contentWidth * 0.05
	timesDeadAchive.y = display.contentHeight * 0.48
	timesDeadAchive:setTextColor( 150, 150, 150 )
	screenGroup:insert( timesDeadAchive )
	
	local dead5 = display.newText( "5", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	dead5:setReferencePoint( display.TopLeftReferencePoint )
	dead5.x = display.contentWidth * 0.3
	dead5.y = display.contentHeight * 0.48
	
	if achive2.dead5 == true then
		dead5:setTextColor( 0, 255, 0 )
	else
		dead5:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( dead5 )
	
	local dead10 = display.newText( "10", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	dead10:setReferencePoint( display.TopLeftReferencePoint )
	dead10.x = display.contentWidth * 0.4
	dead10.y = display.contentHeight * 0.48
	
	if achive2.dead10 == true then
		dead10:setTextColor( 0, 255, 0 )
	else
		dead10:setTextColor( 255, 0, 0 )
	end
	
	screenGroup:insert( dead10 )
	
	local dead15 = display.newText( "15", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	dead15:setReferencePoint( display.TopLeftReferencePoint )
	dead15.x = display.contentWidth * 0.52
	dead15.y = display.contentHeight * 0.48
	
	if achive2.dead15 == true then
		dead15:setTextColor( 0, 255, 0 )
	else
		dead15:setTextColor( 255, 0, 0 )
	end
	screenGroup:insert( dead15 )
	
	local deadCount = display.newText( "15", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	dead15:setReferencePoint( display.TopLeftReferencePoint )
	dead15.x = display.contentWidth * 0.52
	dead15.y = display.contentHeight * 0.48
	
	if achive2.dead15 == true then
		dead15:setTextColor( 0, 255, 0 )
	end 
	
	if achive2.dead5 == true and achive2.dead10 == true and achive2.dead15 == true then
		local allTimesDeadAchive = display.newText( "All done!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
		allTimesDeadAchive:setReferencePoint( display.TopLeftReferencePoint )
		allTimesDeadAchive.x = display.contentWidth * 0.77
		allTimesDeadAchive.y = display.contentHeight * 0.48
		allTimesDeadAchive:setTextColor( 0, 255, 0 )
		screenGroup:insert( allTimesDeadAchive )
	end
	
	local allAchiveText = display.newText( "All achivements:", display.contentWidth, display.contentHeight, native.systemFont, 15 )
	allAchiveText:setReferencePoint( display.TopLeftReferencePoint )
	allAchiveText.x = display.contentWidth * 0.05
	allAchiveText.y = display.contentHeight * 0.7
	allAchiveText:setTextColor( 150, 150, 150 )
	screenGroup:insert( allAchiveText )
	
	if achive2.allachive == true then
	
		local allachive = display.newText( "Done!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
		allachive:setReferencePoint( display.TopLeftReferencePoint )
		allachive.x = display.contentWidth * 0.3
		allachive.y = display.contentHeight * 0.7
		allachive:setTextColor( 0, 255, 0 )
		screenGroup:insert( allachive )
	else
		local allachive = display.newText( "Not done!", display.contentWidth, display.contentHeight, native.systemFont, 15 )
		allachive:setReferencePoint( display.TopLeftReferencePoint )
		allachive.x = display.contentWidth * 0.3
		allachive.y = display.contentHeight * 0.7
		allachive:setTextColor( 255, 0, 0 )
		screenGroup:insert( allachive )
	end
	
	resetBtn = widget.newButton{
		label = "Reset",
		labelColor = { default= {255, 255, 255, 255 },
						over = { 255, 255, 255, 150 } },
		overFile = "resetbtnpressed.png",
		defaultFile = "resetbtn.png",
		onEvent = resetBtnAlert,
	}
	resetBtn:setReferencePoint( display.TopRightReferencePoint )
	resetBtn.x = display.contentWidth * 0.98
	resetBtn.y = display.contentHeight * 0.85
	screenGroup:insert( resetBtn )	
	
end

function resetBtnAlert()

	local alert = native.showAlert( "Reset data!", "Do you want to reset all data for time attack game mode?", { "No!" , "Yes!" }, alertBtn )

end

function alertBtn( event )
		
	local action = event.action
	
	if "clicked" == event.action then
		
		if event.index == 2 then
			resetScore()
		end
		
		if event.index == 1 then
			
		end
		
	elseif "cancelled" == event.action then
	
	end
	
end

function resetScore()
	
		game2settings.score = 0
		game2settings.highscore = 0
		game2settings.medel = 0
		game2settings.runs = 0
		game2settings.hasDied = false
		game2settings.timesdead = 0
		saveTable( game2settings, "game2settings.json")
		
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
		
		storyboard.gotoScene( "start", "fade", 400 )
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

function scene:enterScene( event )
	
	background:addEventListener( "touch", start )
	
end

function scene:exitScene( event )

	background:removeEventListener( "touch", start )
	settings.mute = mute
	saveTable( achive2, "achive2.json" )
	saveTable(settings,"settings.json")

end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene