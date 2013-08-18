io.stdout:setvbuf("no")



function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()

	image = love.graphics.newImage("images/ball.png")
	paddle1 = love.graphics.newImage("images/paddle.png")
	paddle2 = love.graphics.newImage("images/paddle.png")

	--ball
	x = width / 2
	y = height / 2
	ballVelocityX = 300
	ballVelocityY = 30

	-- Paddle 1
	paddle1X = 0
	paddle1Y = height / 2

	--Paddle 2
	paddle2X = width - paddle2:getWidth()
	paddle2Y = height / 2
	times = 0
end


function love.draw()
	love.graphics.draw(image,x,y)
	love.graphics.draw(paddle1,paddle1X,paddle1Y)
	love.graphics.draw(paddle2,paddle2X,paddle2Y)
	--print("Image is at: " .. tostring(x) .. "," .. tostring(y))
end

function love.update(dt)
	times = times + 1
	if times == 60 then
		times = 0
		print("x is:" .. x .. "and y is" .. y .. "and dt is:" .. dt)
	end

	-- Check for Paddle 1 Input
	if love.keyboard.isDown("w") and paddle1Y > 0 then
        paddle1Y = paddle1Y + dt * -600  -- we will increase the variable by 1 for every second the key is held down
    end
	if love.keyboard.isDown("s") and paddle1Y < (height - paddle1:getHeight()) then
        paddle1Y = paddle1Y + dt * 600  -- we will increase the variable by 1 for every second the key is held down
    end


	-- If x moves faster than y at the beggining then it will never
	-- bounce of uppper and lower walls first.
	-- dt * speedX = means it will move that amount of pixels per second

	if ((paddle1X + paddle1:getWidth() >= x) and (paddle1X <= x + image:getWidth())) 
		and ((paddle1Y + paddle1:getHeight() >= y) and (paddle1Y <= y + image:getHeight()))	then
		ballVelocityX = ballVelocityX * -1
	end
	-- Hit Test for Paddle 2
	if ((paddle2X + paddle2:getWidth() >= x) and (paddle2X <= x + image:getWidth()))
		and ((paddle2Y + paddle2:getHeight() >= y) and (paddle2Y <= y + image:getHeight())) then
		ballVelocityX = ballVelocityX * -1
	end

  	x = x + dt * ballVelocityX
  	y = y + dt * ballVelocityY
  	
end