local navigation = {}
local basalt = require("/apis/basalt") -- we need basalt here

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
        local posX = navFlex:addLabel():setText("Y: 0"):setBackground(colors.lightGray):setForeground(colors.white):setSize(10,1):setTextAlign("center")
        navFlex:addBreak()
        local posX = navFlex:addLabel():setText("Z: 0"):setBackground(colors.lightGray):setForeground(colors.white):setSize(10,1):setTextAlign("center")

        navFlex:addBreak()
        navFlex:addBreak()

        navFlex:addLabel():setText("Heading:"):setSize(10, 1)
        local heading = navFlex:addLabel():setText("0"):setBackground(colors.gray):setForeground(colors.white):setSize(3,1):setTextAlign("center")

        navFlex:addBreak()
        navFlex:addBreak()

        navFlex:addLabel():setText("Rotation:"):setSize(10, 1)
        navFlex:addBreak()
        local roll = navFlex:addLabel():setText("Roll: 0"):setBackground(colors.red):setForeground(colors.white):setSize(11,1)
        navFlex:addBreak()
        local pitch = navFlex:addLabel():setText("Pitch: 0"):setBackground(colors.green):setForeground(colors.white):setSize(11,1)
        navFlex:addBreak()
        local yaw = navFlex:addLabel():setText("Yaw: 0"):setBackground(colors.blue):setForeground(colors.white):setSize(11,1)

        navFlex:addBreak()
        navFlex:addBreak()

        navFlex:addLabel():setText("Velocity:"):setSize(10, 1)
        local velocity = navFlex:addLabel():setText("0"):setBackground(colors.gray):setForeground(colors.white):setSize(11,1)

        local returnButton = page:addButton()
        returnButton:setBackground(colors.red)
        returnButton:setSize(3, 1)
        returnButton:setText("<")

        returnButton:onClick(function(self, event, button, x, y)
            page:remove()
            page:remove()
        end)
    end)
end

return navigation
