io.stdout:setvbuf("no")



function love.load()
	--Get Size of Screen
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	--load Resources
	ball = love.graphics.newImage("images/ball.png")
	paddle1 = love.graphics.newImage("images/paddle.png")
	paddle2 = love.graphics.newImage("images/paddle.png")

	--ball
	ballX = screenWidth / 2
	ballY = screenHeight / 2
	ballVelocityX = 300
	ballVelocityY = -30

	-- Paddle 1
	paddle1X = 0
	paddle1Y = screenHeight / 2

	--Paddle 2
	paddle2X = screenWidth - paddle2:getWidth()
	paddle2Y = screenHeight / 2
	times = 0
end


function love.draw()
	love.graphics.draw(ball,ballX,ballY)
	love.graphics.draw(paddle1,paddle1X,paddle1Y)
	love.graphics.draw(paddle2,paddle2X,paddle2Y)
	--print("Image is at: " .. tostring(x) .. "," .. tostring(y))
end

function love.update(dt)
	times = times + 1
	if times == 60 then
		times = 0
		--print("ballX is:" .. ballX .. "and y is" .. ballY .. "and dt is:" .. dt)
	end

	-- Check for Paddle 1 Input
	if love.keyboard.isDown("w") and paddle1Y > 0 then
        paddle1Y = paddle1Y + dt * -600  -- 600 px/s sounds ok
    end
	if love.keyboard.isDown("s") and paddle1Y < (screenHeight - paddle1:getHeight()) then
        paddle1Y = paddle1Y + dt * 600  -- 600 px/s sounds ok
    end


    -- logic for paddle 2 ( CPU )
    if(paddle2Y > ballY - 10) then
    	paddle2Y = paddle2Y + dt * -60
    end
    if(paddle2Y < ballY - 10) then
    	paddle2Y = paddle2Y + dt * 60
    end


	-- If ballX moves faster than y at the beggining then it will never
	-- bounce of uppper and lower walls first.
	-- dt * speedX = means it will move that amount of pixels per second

	--Hit test for Paddle 1
	if ((paddle1X + paddle1:getWidth() >= ballX) and (paddle1X <= ballX + ball:getWidth())) 
		and ((paddle1Y + paddle1:getHeight() >= ballY) and (paddle1Y <= ballY + ball:getHeight()))	then
		if(ballVelocityX < 0) then
			-- print(ballVelocityX)
			ballVelocityX = ballVelocityX * -1
		end
	end
	-- Hit Test for Paddle 2
	if ((paddle2X + paddle2:getWidth() >= ballX) and (paddle2X <= ballX + ball:getWidth()))
		and ((paddle2Y + paddle2:getHeight() >= ballY) and (paddle2Y <= ballY + ball:getHeight())) then
		if(ballVelocityX > 0) then
			ballVelocityX = ballVelocityX * -1
		end
	end

  	ballX = ballX + dt * ballVelocityX
  	ballY = ballY + dt * ballVelocityY
  	
end

function detect_collision(p,px,py,b,bx,by)
	-- body
	--Hit test for Paddle 1
	local collision = false
	if ((px + p:getWidth() >= bx) and (px <= bx + b:getWidth())) and (py + p:getHeight() >= by) and (py <= by + b:getHeight()) then
		collision = true
	else
		collision = false
	end
	return collision
end