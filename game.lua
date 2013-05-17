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
	mute = settings.mute
	bonusTime = 0
	timeCheck = os.time()
	pauseTime = false
	
	local screenGroup = self.view
		
	local background = display.newImage( "bg.png" )
	screenGroup:insert( background )
	
	local cityFix = display.newImage( "citybluefix.png" )
	screenGroup:insert( cityFix )
	
	scrollImg1 = display.newImage( "scrollimg4.png" )
	scrollImg1.x = 240
	scrollImg1.speed = 3
	screenGroup:insert( scrollImg1 )

	scrollImg3 = display.newImage( "scrollimg4.png" )
	scrollImg3.x = 720
	scrollImg3.speed = 3
	screenGroup:insert( scrollImg3 )
	
	local cityFix2 = display.newImage( "citygrayfix.png" )
	screenGroup:insert( cityFix2 )

	scrollImg2 = display.newImage( "scrollimg3.png" )
	scrollImg2.x = 240
	scrollImg2.speed = 5
	screenGroup:insert( scrollImg2 )

	scrollImg4 = display.newImage( "scrollimg3.png" )
	scrollImg4.x = 720
	scrollImg4.speed = 5
	screenGroup:insert( scrollImg4 )
	
	arrow = display.newImage( "arrow01.png" )
	arrow.x = -80
	arrow.y = 100
	physics.addBody( arrow, "static", { density = 0.09, bounce = .1, friction = .2, radius = 12 } )
	screenGroup:insert( arrow )
	arrowIntro = transition.to( arrow, {time = 1500, x=100, onComplete = arrowReady } )
	arrow.collided = false
	
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
	
	local scoreText = display.newText( "Score:", 20, 20, "Helvetica", 18 )
	screenGroup:insert( scoreText )
	
	pointText = display.newText( "0", 80, 20, "Helvetica", 18 )
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
		if runTime < 15 then
			self.x = 710
			self.y = math.random( 100, 150 )
			self.speed = math.random( 4, 6 )
			self.amp = math.random( 20, 50 )
			self.angle = math.random( 1, 360 )
		
		else if runTime >= 15 and runTime < 30 then
			self.x = 710
			self.y = math.random( 100, 150 )
			self.speed = math.random( 5, 7 )
			self.amp = math.random( 50, 100 )
			self.angle = math.random( 1, 360 )
			
			scrollImg1.speed = 4
			scrollImg3.speed = 4
			scrollImg2.speed = 6
			scrollImg4.speed = 6
			
		else if runTime >= 30 then
			self.x = 710
			self.y = math.random( 100, 150 )
			self.speed = math.random( 6, 8 )
			self.amp = math.random( 70, 100 )
			self.angle = math.random( 1, 360 )
			
			scrollImg1.speed = 5
			scrollImg3.speed = 5
			scrollImg2.speed = 7
			scrollImg4.speed = 7
			
		end
		end
		end
	else
		self.x = self.x - self.speed
		self.angle = self.angle + 0.1
		self.y = self.amp * math.sin( self.angle ) + self.initY
	end
	return true
end

function moveCircle2( self, event )
	local runTime = os.time() - startTime
	
	if self.x < -20 then
		if runTime < 15 then
			self.x = 710
			self.y = math.random( 150, 300 )
			self.speed = math.random( 4, 6 )
			self.amp = math.random( 20, 50 )
			self.angle = math.random( 1, 360 )
		
		else if runTime >= 15 and runTime < 30 then
			self.x = 710
			self.y = math.random( 150, 300 )
			self.speed = math.random( 4, 7 )
			self.amp = math.random( 50, 100 )
			self.angle = math.random( 1, 360 )
			
		else if runTime >= 30 then
			self.x = 710
			self.y = math.random( 150, 300 )
			self.speed = math.random( 6, 8 )
			self.amp = math.random( 70, 100 )
			self.angle = math.random( 1, 360 )
			
		end
		end
		end
	else
		self.x = self.x - self.speed
		self.angle = self.angle + 0.1
		self.y = self.amp * math.sin( self.angle ) + self.initY
	end
	return true
end

function moveCircle3( self, event )
	local runTime = os.time() - startTime
	
	if self.x < -20 then
		if runTime < 15 then
			self.x = 710
			self.y = math.random( 300, 350 )
			self.speed = math.random( 4, 6 )
			self.amp = math.random( 20, 50 )
			self.angle = math.random( 1, 360 )
		
		else if runTime >= 15 and runTime < 30 then
			self.x = 710
			self.y = math.random( 300, 350 )
			self.speed = math.random( 4, 7 )
			self.amp = math.random( 50, 100 )
			self.angle = math.random( 1, 360 )
			
		else if runTime >= 30 then
			self.x = 710
			self.y = math.random( 300, 350 )
			self.speed = math.random( 6, 8 )
			self.amp = math.random( 70, 100 )
			self.angle = math.random( 1, 360 )
			
		end
		end
		end
	else
		self.x = self.x - self.speed
		self.angle = self.angle + 0.1
		self.y = self.amp * math.sin( self.angle ) + self.initY
	end
	return true
end


function gameOver()
   storyboard.gotoScene("restart", "fade", 400)
end

function onCollision( event )
	
	local enemyHitSound = audio.loadSound( "explode2.wav" )
	settings.score = os.time() - startTime + bonusTime
	pointText.text = os.time() - startTime + bonusTime
	
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
	
	--print("Close")
	if arrow.collided == false then
		if isDrifting == 0 then
		
			if DisEnemy1 < 70 and DisEnemy2 < 70 then
				bonusTime = bonusTime + 15
				print("Close")
				makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=2000, yVal=-50} )
				isDrifting = 30
			
			elseif DisEnemy1 < 70 and DisEnemy3 < 70 then
				bonusTime = bonusTime + 15
				print("Close")
				makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=1000, yVal=-50} )
				isDrifting = 30
				
			elseif DisEnemy2 < 70 and DisEnemy3 < 70 then
				bonusTime = bonusTime + 15
				print("Close")
				makeDriftingText( "+15", {y=arrow.y, x=arrow.x, t=1000, yVal=-50} )
				isDrifting = 30
				
			elseif DisEnemy1 < 45 or DisEnemy2 < 45 or DisEnemy3 < 45 then
				bonusTime = bonusTime + 5
				print("Close")
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
    local fontSize = 15
	
		local dTxt = display.newText( txt, 0, 0, fontFace, fontSize )
		dTxt.x = x
		dTxt.y = y
		
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
	pointText.text = (os.time() - startTime) + bonusTime
end

function scene:enterScene( event )
	
	storyboard.purgeScene("restart")
	
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
	
	enemy2.enterFrame = moveCircle2
	Runtime:addEventListener( "enterFrame", enemy2 )
	
	enemy3.enterFrame = moveCircle3
	Runtime:addEventListener( "enterFrame", enemy3 )
	
	Runtime:addEventListener( "enterFrame", closeFly )
	
	Runtime:addEventListener( "enterFrame", checkMove )
	
	Runtime:addEventListener( "collision", onCollision )
	
	Runtime:addEventListener( "enterFrame", displayPointText )
	
	startTime = os.time()
	
	isDrifting = 0
	
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
	
	
	
	
	settings.mute = mute
	settings.bonusTime = bonusTime
	settings.pauseTime = pauseTime
	saveTable(settings, "settings.json")
	
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
