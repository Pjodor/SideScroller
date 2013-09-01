-- Requires
local json = require "json"
local widget = require "widget"
local physics = require "physics"
physics.start()

require "sprite"

local storyboard = require "storyboard"
local scene = storyboard.newScene()

function scene:createScene( event )
	
	settings = loadTable("settings.json")
	game2settings = loadTable( "game2settings.json")
	achive = loadTable("achive.json")
	achive2 = loadTable("achive2.json")	
	
	mute = settings.mute
	bonusTime = 0
	timeCheck = os.time()
	pauseTime = false
	starTaken = 0
	
	local screenGroup = self.view
		
	local background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	scrollImg1 = display.newImage( "scrollimg4.png" )
	scrollImg1.x = 240
	scrollImg1.speed = 4
	screenGroup:insert( scrollImg1 )

	scrollImg3 = display.newImage( "scrollimg4-2.png" )
	scrollImg3.x = 720
	scrollImg3.speed = 4
	screenGroup:insert( scrollImg3 )

	scrollImg2 = display.newImage( "scrollimg3.png" )
	scrollImg2.x = 240
	scrollImg2.speed = 6	
	screenGroup:insert( scrollImg2 )

	scrollImg4 = display.newImage( "scrollimg3-2.png" )
	scrollImg4.x = 720
	scrollImg4.speed = 6
	screenGroup:insert( scrollImg4 )
	
	if achive.score100 == false then
		arrowSpriteScheet = sprite.newSpriteSheet( "arrowsprite01.png", 26, 18 )
		arrowSprite = sprite.newSpriteSet( arrowSpriteScheet, 1, 3 )
		arrow = sprite.newSprite( arrowSprite )
		arrow.x = -80
		arrow.y = 100
		physics.addBody( arrow, "static", { density = 0.09, bounce = .1, friction = .2, radius = 12 } )
		screenGroup:insert( arrow )
		arrowIntro = transition.to( arrow, {time = 1500, x=100, onComplete = arrowReady } )
		arrow.collided = false
	elseif achive.score100 == true and achive.score200 == false then
		arrowSpriteScheet = sprite.newSpriteSheet( "arrowsprite02.png", 26, 18 )
		arrowSprite = sprite.newSpriteSet( arrowSpriteScheet, 1, 3 )
		arrow = sprite.newSprite( arrowSprite )
		arrow.x = -80
		arrow.y = 100
		physics.addBody( arrow, "static", { density = 0.09, bounce = .1, friction = .2, radius = 12 } )
		screenGroup:insert( arrow )
		arrowIntro = transition.to( arrow, {time = 1500, x=100, onComplete = arrowReady } )
		arrow.collided = false
	elseif achive.score100 == true and achive.score200 == true then
		arrowSpriteScheet = sprite.newSpriteSheet( "arrowsprite03.png", 26, 18 )
		arrowSprite = sprite.newSpriteSet( arrowSpriteScheet, 1, 3 )
		arrow = sprite.newSprite( arrowSprite )
		arrow.x = -80
		arrow.y = 100
		physics.addBody( arrow, "static", { density = 0.09, bounce = .1, friction = .2, radius = 12 } )
		screenGroup:insert( arrow )
		arrowIntro = transition.to( arrow, {time = 1500, x=100, onComplete = arrowReady } )
		arrow.collided = false
	end
	
	explosionSpriteSheet = sprite.newSpriteSheet("explosion.png", 24, 23)
	explosionSprites = sprite.newSpriteSet(explosionSpriteSheet, 1, 8)
	sprite.add(explosionSprites, "explosions", 1, 8, 2000, 1)
	explosion = sprite.newSprite(explosionSprites)
	explosion.x = 100
   	explosion.y = 100
	explosion:prepare("explosions")
	explosion.isVisible = false
	screenGroup:insert(explosion)
	
	enemy1 = display.newImage( "enemy1.png" )
	enemy1.x = 850
	enemy1.y = math.random(150, 250)
	enemy1.speed = math.random( 4, 5 )
	enemy1.initY = enemy1.y
	enemy1.amp = math.random( 20, 50 )
	enemy1.angle = math.random( 1, 360 )
	physics.addBody(enemy1, "static", { density = .1, friction = .2, bounce = .1, radius = 15 } )
	screenGroup:insert( enemy1 )
	
	enemy2 = display.newImage( "enemy2.png" )
	enemy2.x = 650
	enemy2.y = math.random(200, 270)
	enemy2.speed = math.random( 4, 5 )
	enemy2.initY = enemy2.y
	enemy2.amp = math.random( 20, 50 )
	enemy2.angle = math.random( 1, 360 )
	physics.addBody(enemy2, "static", { density = .1, friction = .2, bounce = .1, radius = 15 } )
	screenGroup:insert( enemy2 )
	
	enemy3 = display.newImage( "enemy3.png" )
	enemy3.x = 500
	enemy3.y = math.random(50, 150)
	enemy3.speed = math.random( 4, 5 )
	enemy3.initY = enemy3.y
	enemy3.amp = math.random( 20, 50 )
	enemy3.angle = math.random( 1, 360 )
	physics.addBody(enemy3, "static", { density = .1, friction = .2, bounce = .1, radius = 15 } )
	screenGroup:insert( enemy3 )
	
	star = display.newImage( "star01.png" )
	star.x = 600
	star.y = math.random(50, 300)
	star.speed = math.random( 5, 8 )
	star.initY = star.y
	star.amp = math.random( 20, 50 )
	star.angle = math.random( 1, 360 )
	star.isVisible = true
	screenGroup:insert( star )
	
	topCollider = display.newRect( 0, -20, 480 ,5 )
	physics.addBody( topCollider, "static", { density = .1, friction = .2, bounce = .1 } )
	screenGroup:insert( topCollider )
	
	botCollider = display.newRect( 0, 340, 480 ,5 )
	physics.addBody( botCollider, "static", { density = .1, friction = .2, bounce = .1 } )
	screenGroup:insert( botCollider )
	
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
	
	local timeLeft = display.newText( "Time left:", 20, 20, "Helvetica", 16 )
	screenGroup:insert( timeLeft )
	
	timeLeftText = display.newText( "30", 91, 20, "Helvetica", 16 )
	screenGroup:insert( timeLeftText )
	
	local scoreText = display.newText( "Score:", 120, 20, "Helvetica", 16 )
	screenGroup:insert( scoreText )
	
	pointText = display.newText( "0", 175, 20, "Helvetica", 16 )
	screenGroup:insert( pointText )
	
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


function activateArrow( self, event )

	self:applyForce( 0, -1.5, self.x, self.y )
	
end

function arrowReady( self, event )

	arrow.bodyType = "dynamic"
	
end

function touchScreen( event )
	
	if event.phase == "began" then
		
		arrow.enterFrame = activateArrow
		Runtime:addEventListener( "enterFrame", arrow )
		
	end
	
	if event.phase == "ended" then
	
		Runtime:removeEventListener( "enterFrame", arrow )
		
	end
end

function scrollBackground( self, event )
	if self.x < -240 then
		self.x = 710
	else
		self.x = self.x - self.speed
	end
end



function moveCircle( self, event )
	local runTime = os.time() - startTime
	
	if self.x < -20 then
		self.x = math.random(500,800)
		self.initY = math.random( 50, 250 )
		self.speed = math.random( 5, 7 )
		self.amp = math.random( 50, 100 )
		self.angle = math.random( 1, 360 )

	else
		self.x = self.x - self.speed
		self.angle = self.angle + 0.1
		self.y = self.amp * math.sin( self.angle ) + self.initY
	end
	return true
end

function moveStar( self, event )
	if self.x > -50 and self.x < -10 or self.x > 500 then
		self.x = self.x - 7
	
	elseif self.x < -50 then
			self.x = 710
			self.initY = math.random( 50, 250 )
			self.speed = math.random( 6, 8 )
			self.amp = math.random( 30, 50 )
			self.angle = math.random( 1, 360 )
			self.isVisible = true
	else
		self.x = self.x - self.speed
		self.angle = self.angle + 0.1
		self.y = self.amp * math.sin( self.angle ) + self.initY
	end
	return true
end

function gameOver()
   storyboard.gotoScene("restart2", "fade", 400)
end

function starCollision()
	starCheck = math.sqrt((star.x - arrow.x)^2 + (star.y - arrow.y)^2)
	if arrow.collided == false then
		if isDriftingStar == 0 then
			if starCheck < 20 then
					star.isVisible = false
					makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=2000, yVal=-50} )
					bonusTime = bonusTime + 15
					isDriftingStar = 30	
					starTaken = starTaken + 1
			end
		else
			isDriftingStar = isDriftingStar - 1
		end
	end
	
end

function onCollision( event )
	
	local enemyHitSound = audio.loadSound( "explode2.wav" )
	
	Runtime:removeEventListener( "enterFrame", displayPointText )
	
	if event.phase == "began" and arrow.collided == false then
		
		if mute == false then
		audio.play(enemyHitSound, {
		channel = 2,
		})
		end
		
		if arrow.collided == false then 
			arrow.collided = true
			arrow.bodyType = "static"
			explode()
		end
	end
end

function explode()
	
	explosion.x = arrow.x
	explosion.y = arrow.y
	explosion.isVisible = true
	explosion:play()
	arrow.isVisible = false
	timer.performWithDelay(1500, gameOver, 1)

end

function closeFly()
	
	local DisEnemy1 = math.sqrt((enemy1.x - arrow.x)^2+(enemy1.y - arrow.y)^2)
	local DisEnemy2 = math.sqrt((enemy2.x - arrow.x)^2+(enemy2.y - arrow.y)^2)
	local DisEnemy3 = math.sqrt((enemy3.x - arrow.x)^2+(enemy3.y - arrow.y)^2)
	
	if arrow.collided == false then
		if isDrifting == 0 then
		
			if DisEnemy1 < 65 and DisEnemy2 < 65 then
				bonusTime = bonusTime + 15
				makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=2000, yVal=-50} )
				isDrifting = 30
				
			elseif DisEnemy1 < 65 and DisEnemy3 < 65 then
				bonusTime = bonusTime + 15
				makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=1000, yVal=-50} )
				isDrifting = 30
				
			elseif DisEnemy2 < 65 and DisEnemy3 < 65 then
				bonusTime = bonusTime + 15
				makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=1000, yVal=-50} )
				isDrifting = 30
				
			elseif DisEnemy1 < 50 or DisEnemy2 < 50 or DisEnemy3 < 50 then
				bonusTime = bonusTime + 5
				makeDriftingText( "+5", {y=arrow.y, x=arrow.x, t=2000, yVal=-50} )
				isDrifting = 30
			end
		
		else
			isDrifting = isDrifting - 1
		end
	end
	
end

function makeDriftingText(txt, opts)

	local opts = opts or {}
    local dTime = opts.t or 2000
    local del = opts.del or 0
    local yVal = opts.yVal or -40
    local x = opts.x or display.contentCenterX
    local y = opts.y or display.contentCenterY
    local fontFace = "Helvetica"
    local fontSize = opts.fontSize or 15
	local fontColor = opts.fontColor or 0
	
		local dTxt = display.newText( txt, 0, 0, fontFace, fontSize )
		dTxt.x = x
		dTxt.y = y
		
		if fontColor == 0 then
			dTxt:setTextColor( 255, 255, 255 )
		elseif fontColor == 1 then
			dTxt:setTextColor( 255, 0, 0 )
		end
		
		if opts.grp then
			opts.grp:insert(dTxt)
		end
		
		local function killDTxt(obj)
			display.remove( obj )
			obj = nil
		end
		
		transition.to( dTxt,  { delay=del, time=dTime, y=y+yVal, alpha=0, onComplete=killDTxt } ) 
		
end

function checkMove()
	
	timeCheck = os.time() - timeCheck
	
	if timeCheck > 1 then
		startTime = os.time()
		bonusTime = 0
		pauseTime = true
		storyboard.gotoScene( "restart", "fade", 300 )
	else
		timeCheck = os.time()
	end
	
end

function displayPointText()
	pointText.text = bonusTime
	
	local checkScore = bonusTime
	
	if checkScore < 100 and checkScore >= 50 then
	
		arrow.currentFrame = 2
		
	elseif checkScore >= 100 then
	
		arrow.currentFrame = 3
		
	end
	
end


function displayTimeLeft()

	local timeLeftCheck = 30 - (os.time() - startTime)
	
	if timeLeftCheck > -1 then
	
		timeLeftText.text = 30 - (os.time() - startTime)
	
	end
	
	if isDriftingTime == 0 then
	
		if timeLeftCheck == 0 and arrow.collided == false then
			
			arrow.collided = true
			arrow.bodyType = "static"
			explode()
			
			makeDriftingText( "Time is up!", {t=1000, yVal=-50, fontSize=55, fontColor = 1 } )
			isDriftingTime = 31
			
			timer.performWithDelay( 800, completeTimePoints )
			
		elseif timeLeftCheck == 1 and arrow.collided == false then
			
				makeDriftingText( "1", {t=1000, yVal=-50, fontSize=55, fontColor = 1 } )
				isDriftingTime = 32
			
		elseif timeLeftCheck == 2 and arrow.collided == false then
		
				makeDriftingText( "2", {t=1000, yVal=-50, fontSize=55, fontColor = 1 } )
				isDriftingTime = 32
			
		elseif timeLeftCheck == 3 and arrow.collided == false then
			
				makeDriftingText( "3", {t=1000, yVal=-50, fontSize=55, fontColor = 1 } )
				isDriftingTime = 32
			
		elseif timeLeftCheck == 4 and arrow.collided == false then
			
				makeDriftingText( "4", {t=1000, yVal=-50, fontSize=55, fontColor = 1 } )
				isDriftingTime = 32
		
		elseif timeLeftCheck == 5 and arrow.collided == false then
		
				makeDriftingText( "5", {t=1000, yVal=-50, fontSize=55, fontColor = 1 } )
				isDriftingTime = 32
		end
	
	else
	
		isDriftingTime = isDriftingTime - 1
		
	end
	
end

function completeTimePoints( event )

	makeDriftingText( "Time bonus: +20!", {t=1000, yVal=-50, fontSize=30, fontColor = 0 } )
	
	bonusTime = bonusTime + 20
	
end

function round(theNos, precision)

	return math.floor(theNos*math.pow(10,precision)+0.5) / math.pow(10,precision)
	
end

function scene:enterScene( event )
	
	storyboard.removeScene("game")
	storyboard.removeScene("restart2")
	
	Runtime:addEventListener( "touch", touchScreen )
	
	scrollImg1.enterFrame = scrollBackground
	Runtime:addEventListener( "enterFrame", scrollImg1 )

	scrollImg2.enterFrame = scrollBackground
	Runtime:addEventListener( "enterFrame", scrollImg2 )

	scrollImg3.enterFrame = scrollBackground
	Runtime:addEventListener( "enterFrame", scrollImg3 )

	scrollImg4.enterFrame = scrollBackground
	Runtime:addEventListener( "enterFrame", scrollImg4 )
	
	enemy1.enterFrame = moveCircle
	Runtime:addEventListener( "enterFrame", enemy1 )
	
	enemy2.enterFrame = moveCircle
	Runtime:addEventListener( "enterFrame", enemy2 )
	
	enemy3.enterFrame = moveCircle
	Runtime:addEventListener( "enterFrame", enemy3 )
	
	star.enterFrame = moveStar
	Runtime:addEventListener( "enterFrame", star )
	
	Runtime:addEventListener( "enterFrame", starCollision )
	
	Runtime:addEventListener( "enterFrame", closeFly )
	
	Runtime:addEventListener( "enterFrame", checkMove )
	
	Runtime:addEventListener( "collision", onCollision )
	
	Runtime:addEventListener( "enterFrame", displayPointText )
	
	Runtime:addEventListener( "enterFrame", displayTimeLeft )
	
	startTime = os.time()
	
	isDrifting = 0
	isDriftingTime = 0
	isDriftingStar = 0
	
		
end

function scene:exitScene( event )

	Runtime:removeEventListener( "touch", touchScreen )
	Runtime:removeEventListener( "enterFrame", scrollImg1 )
	Runtime:removeEventListener( "enterFrame", scrollImg2 )
	Runtime:removeEventListener( "enterFrame", scrollImg3 )
	Runtime:removeEventListener( "enterFrame", scrollImg4 )
	Runtime:removeEventListener( "enterFrame", enemy1 )
	Runtime:removeEventListener( "enterFrame", enemy2 )
	Runtime:removeEventListener( "enterFrame", enemy3 )
	Runtime:removeEventListener( "collision", onCollision )
	Runtime:removeEventListener( "enterFrame", closeFly )
	Runtime:removeEventListener( "enterFrame", checkMove )
	Runtime:removeEventListener( "enterFrame", displayPointText )
	Runtime:removeEventListener( "enterFrame", starCollision )
	Runtime:removeEventListener( "enterFrame", moveStar )
	Runtime:removeEventListener( "enterFrame", displayTimeLeft )
	
	settings.mute = mute
	
	game2settings.pauseTime = pauseTime
	game2settings.score = bonusTime
	game2settings.runs = game2settings.runs + 1
	game2settings.medel = (game2settings.medel * (game2settings.runs - 1) + game2settings.score)/game2settings.runs
	
	game2settings.medel = round( game2settings.medel, 2 )
	
	if game2settings.score > game2settings.highscore then
		game2settings.highscore = game2settings.score
		game2settings.newHighScore = true
	end
	
	timePlayed = os.time() - startTime
	
	if timePlayed < 15 then
	
		game2settings.timesdead = game2settings.timesdead + 1
		
	end
	
	if game2settings.score >= 50 then
		achive2.score50 = true
	end
	
	if game2settings.score >= 100 then
		achive2.score100 = true
	end
	
	if game2settings.score >= 150 then
		achive2.score150 = true
	end
	
	if game2settings.score >= 200 then
		achive2.score200 = true
	end
	
	if game2settings.runs >= 50 then
		achive2.played50 = true
	end
	
	if game2settings.runs >= 100 then
		achive2.played100 = true
	end
	
	if game2settings.runs >= 200 then
		achive2.played200 = true
	end
	
	if starTaken >= 4 then
		achive2.star4 = true
	end
	
	if starTaken >= 6 then
		achive2.star7 = true
	end
	
	if starTaken >= 8 then
		achive2.star10 = true
	end
	
	if game2settings.timesdead >= 5 then
		achive2.dead5 = true
	end
	
	if game2settings.timesdead >= 10 then
		achive2.dead10 = true
	end
	
	if game2settings.timesdead >= 15 then
		achive2.dead15 = true
	end
	
	saveTable(achive2, "achive2.json")
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
