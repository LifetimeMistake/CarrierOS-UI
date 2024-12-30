local navigation = {}
local basalt = require("/apis/basalt") -- we need basalt here

function math.round(value, num)
    num = num or 1
    local power = math.pow(10, num)
    return math.floor(value*power)/power
end

function navigation.page(main, buttonsFlex, api)
    local screenWidth, screenHeight = main:getSize()

    local mainPageButton = buttonsFlex:addButton()
    mainPageButton:setBackground(colors.black)
    mainPageButton:setForeground(colors.white)
    mainPageButton:setText("Navigation")
    mainPageButton:setSize(15, "self.h")

    mainPageButton:onClick(function(self, event, button, x, y)
        page = main:addFrame()
        page:setSize("parent.w", "parent.h")
        page:setBackground(colors.lightGray)

        local bar = page:addFrame()
        bar:setSize("parent.w-3", 1)
        bar:setPosition(4, 1)

        local navigationPage = page:addFrame()
        navigationPage:setSize("parent.w", "parent.h-1")
        navigationPage:setPosition(1, 2)
        navigationPage:setBackground(colors.lightGray)

        local navFlex = navigationPage:addFlexbox()
        navFlex:setSize("parent.w", "parent.h-1")
        navFlex:setPosition(1, 2)
        navFlex:setBackground(colors.lightGray)
        navFlex:setJustifyContent("center")
        navFlex:setSpacing(0)

        navFlex:addLabel():setText("Position:"):setSize(10, 1)
        navFlex:addBreak()
        local posX = navFlex:addLabel():setText("X: 0"):setBackground(colors.lightGray):setForeground(colors.white):setSize(10,1):setTextAlign("center")
        navFlex:addBreak()
        local posY = navFlex:addLabel():setText("Y: 0"):setBackground(colors.lightGray):setForeground(colors.white):setSize(10,1):setTextAlign("center")
        navFlex:addBreak()
        local posZ = navFlex:addLabel():setText("Z: 0"):setBackground(colors.lightGray):setForeground(colors.white):setSize(10,1):setTextAlign("center")

        navFlex:addBreak()
        navFlex:addBreak()

        navFlex:addLabel():setText("Rotation:"):setSize(10, 1)
        navFlex:addBreak()
        local roll = navFlex:addLabel():setText("Roll: 0"):setBackground(colors.red):setForeground(colors.white):setSize(15,1)
        navFlex:addBreak()
        local pitch = navFlex:addLabel():setText("Pitch: 0"):setBackground(colors.green):setForeground(colors.white):setSize(15,1)
        navFlex:addBreak()
        local yaw = navFlex:addLabel():setText("Yaw: 0"):setBackground(colors.blue):setForeground(colors.white):setSize(15,1)

        navFlex:addBreak()
        navFlex:addBreak()

        navFlex:addLabel():setText("Velocity:"):setSize(10, 1)
        local velocity = navFlex:addLabel():setText("0"):setBackground(colors.gray):setForeground(colors.white):setSize(11,1)

        local function updatePage()
            while true do
                local navigationInfo = api.navigation.getInfo()
                
                local position = navigationInfo.position
                local vel = navigationInfo.velocity
                local rotation = navigationInfo.rot
        
                posX:setText("X: " .. math.round(position.x, 2))
                posY:setText("Y: " .. math.round(position.y, 2))
                posZ:setText("Z: " .. math.round(position.z, 2))

                roll:setText("Roll: " .. math.round(math.deg(rotation.z), 2))
                pitch:setText("Pitch: " .. math.round(math.deg(rotation.x), 2))
                yaw:setText("Yaw: " .. math.round(math.deg(rotation.y), 2))

                local magnitude = math.round(math.sqrt(vel.x*vel.x + vel.y*vel.y + vel.z*vel.z), 2)
                
                velocity:setText(magnitude .. " m/s")

                os.sleep(1)
            end
        end

        local updatePageThread = main:addThread()

        local returnButton = page:addButton()
        returnButton:setBackground(colors.red)
        returnButton:setSize(3, 1)
        returnButton:setText("<")

        returnButton:onClick(function(self, event, button, x, y)
            updatePageThread:stop()
            page:remove()
            page:remove()
        end)

        updatePageThread:start(updatePage)
    end)
end

return navigation
