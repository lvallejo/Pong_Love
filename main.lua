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
	print(ballX .. "," .. ballY)
	ballVelocityX = 200
	ballVelocityY = -150

	-- Paddle 1
	paddle1X = 0
	paddle1Y = screenHeight / 2
	paddle1Velocity = 600

	--Paddle 2
	paddle2X = screenWidth - paddle2:getWidth()
	paddle2Y = screenHeight / 2
	paddle2Velocity = 1

	ballBounce = true
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

    ballY = ballY + dt * ballVelocityY
  	ballX = ballX + dt * ballVelocityX
  	--print("Ball:(" .. ballX .. "," .. ballY ..")")
    -- logic for paddle 2 ( CPU )
    
    if(ballBounce) then
    	if(ballVelocityX > 0) then
    		ty = line_intersect(ballX,ballY,ballVelocityX,ballVelocityY)
    		print(ty)
    	-- Going down
    		if(ty > paddle2Y) then
    			paddle2Y = ty - dt * paddle2Velocity
    			print(paddle2Y)
    			ballBounce = false
    		else
    			paddle2Y = ty + dt * paddle2Velocity
    			ballBounce = false
    		end

    	end
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
			ballBounce = true
		end
	end
	-- Hit Test for Paddle 2
	if ((paddle2X + paddle2:getWidth() >= ballX) and (paddle2X <= ballX + ball:getWidth()))
		and ((paddle2Y + paddle2:getHeight() >= ballY) and (paddle2Y <= ballY + ball:getHeight())) then
		if(ballVelocityX > 0) then
			ballVelocityX = ballVelocityX * -1
			ballBounce = true
		end
	end

	if(ballY < 0) then
		ballVelocityY = ballVelocityY * -1
		ballBounce = true
	end
	if(ballY > screenHeight - ball:getHeight()) then
		ballVelocityY = ballVelocityY * -1
		ballBounce = true
	end
	
  	
  	
end

function line_intersect(bx,by,vx,vy)
	-- tx = target of X
	 tx = screenWidth - 16 --- 16 being the width of the paddle
	 slope = (tx - bx) / vx
	 ty = by + slope * vy
	 return ty
end


-- Unused 
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