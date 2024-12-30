local rc = {}
local basalt = require("/apis/basalt") -- we need basalt here

function rc.page(main, buttonsFlex, api)
    local screenWidth, screenHeight = main:getSize()

    local mainPageButton = buttonsFlex:addButton()
    mainPageButton:setBackground(colors.black)
    mainPageButton:setForeground(colors.white)
    mainPageButton:setText("RC")
    mainPageButton:setSize(15, "self.h")

    mainPageButton:onClick(function(self, event, button, x, y)
        local alertBox = main:addFrame():hide()
        alertBox:setSize(22, 4)
        alertBox:setPosition("parent.w-21", "parent.h-3")
        alertBox:setBackground(colors.red)
        alertBox:setZIndex(25)

        local alertBoxClose = alertBox:addButton():setSize(1,1):setText("X"):setBackground(colors.red):setForeground(colors.white)
        local alertBoxText = alertBox:addLabel():setSize(19,3):setText("Disable Autopilot before engaging RC!"):setPosition(2,2)

        alertBoxClose:onClick(function ()
            alertBox:hide()
        end)

        if api.autopilot.getEnabled() then
            alertBox:show()
            return
        end

        page = main:addFrame()
        page:setSize("parent.w", "parent.h")
        page:setBackground(colors.lightGray)

        local bar = page:addFrame()
        bar:setSize("parent.w-3", 1)
        bar:setPosition(4, 1)

        local rcPage = page:addFrame()
        rcPage:setSize("parent.w", "parent.h-1")
        rcPage:setPosition(1, 2)
        rcPage:setBackground(colors.lightGray)

        local remoteFlex = rcPage:addFlexbox()
        remoteFlex:setSize("parent.w", "parent.h-1")
        remoteFlex:setPosition(1, 2)
        remoteFlex:setBackground(colors.lightGray)
        remoteFlex:setJustifyContent("center")

        local vectorLabel = remoteFlex:addLabel()
        vectorLabel:setText("0 0 0")
        vectorLabel:setBackground(colors.lightGray):setForeground(colors.black)
        vectorLabel:setSize(13, 1)
        vectorLabel:setTextAlign("center")

        remoteFlex:addBreak()

        local headingLabel = remoteFlex:addLabel()
        headingLabel:setText("|nil|")
        headingLabel:setBackground(colors.lightGray):setForeground(colors.black):setSize(13, 1):setTextAlign("center")

        remoteFlex:addBreak()

        local rcVector = {
            x = 0, -- side
            y = 0, -- alt
            z = 0, -- thrust
        }
        local rcHeading = nil

        local vectorIncrementValues = { 1, 10, 100 }
        local headingIncrementValues = { 1, 15, 45, 90 }
        local vectorIncrement = 1
        local headingIncrement = 1

        local function getVectorIncrement()
            return vectorIncrementValues[vectorIncrement]
        end

        local function getHeadingIncrement()
            return headingIncrementValues[headingIncrement]
        end

        -- local vectorLabel = page:addLabel()
        -- vectorLabel:setSize("parent.w", 1)
        -- vectorLabel:setBackground(colors.red)

        -- local headingLabel = page:addLabel()
        -- headingLabel:setSize("parent.w", 1)
        -- headingLabel:setPosition(1, 2)

        local function sendData()
            api.rc.setFlightVector(rcVector, rcHeading)
        end

        local function switchIncrement(incrementType)
            if incrementType == "vector" then
                vectorIncrement = (vectorIncrement % #vectorIncrementValues) + 1
            elseif incrementType == "heading" then
                headingIncrement = (headingIncrement % #headingIncrementValues) + 1
            end
        end

        local function incrementVector(axis, value)
            if axis == "x" then
                rcVector.x = rcVector.x + value
            elseif axis == "y" then
                rcVector.y = rcVector.y + value
            elseif axis == "z" then
                rcVector.z = rcVector.z + value
            end

            vectorLabel:setText(rcVector.x .. " " .. rcVector.y .. " " .. rcVector.z)
            sendData()
        end

        local function incrementHeading(value)
            if rcHeading == nil then
                rcHeading = 0
            end
        
            rcHeading = (rcHeading + value) % 360

            if rcHeading < 0 then
                rcHeading = rcHeading + 360
            end
        
            headingLabel:setText(rcHeading)
            sendData()
        end
        

        local function resetVector()
            rcVector = {
                x = 0,
                y = 0,
                z = 0
            }
            vectorLabel:setText(rcVector.x .. " " .. rcVector.y .. " " .. rcVector.z)
            sendData()
        end

        local function resetHeading()
            rcHeading = nil
            headingLabel:setText(rcHeading)
            sendData()
        end

        local altUp = remoteFlex:addButton():setText("+"):setSize(3,3):setBackground(colors.blue):setForeground(colors.white)
        local thrustForward = remoteFlex:addButton():setText("^"):setSize(3,3):setBackground(colors.gray):setForeground(colors.lightGray)
        local altDown = remoteFlex:addButton():setText("-"):setSize(3,3):setBackground(colors.red):setForeground(colors.white)

        remoteFlex:addBreak()

        local hdgLeft = remoteFlex:addButton():setText("<--"):setSize(5,3):setBackground(colors.black):setForeground(colors.gray)
        local latLeft = remoteFlex:addButton():setText("<"):setSize(3,3):setBackground(colors.gray):setForeground(colors.lightGray)
        local reset = remoteFlex:addButton():setText("O"):setSize(3,3):setBackground(colors.black):setForeground(colors.gray)
        local latRight = remoteFlex:addButton():setText(">"):setSize(3,3):setBackground(colors.gray):setForeground(colors.lightGray)
        local hdgRight = remoteFlex:addButton():setText("-->"):setSize(5,3):setBackground(colors.black):setForeground(colors.gray)

        remoteFlex:addBreak()

        local vecSwitch = remoteFlex:addFrame():setBackground(colors.black):setSize(3,3)
        vecSwitch:addLabel():setBackground(colors.black):setSize(3,1):setForeground(colors.white):setText("VEC")
        vecSwitch:addLabel():setBackground(colors.black):setSize(3,1):setForeground(colors.white):setText("---"):setPosition(1,2)
        local vecValue = vecSwitch:addLabel():setBackground(colors.black):setSize(3,1):setForeground(colors.white):setText("1"):setPosition(1,3)

        local thrustBackward = remoteFlex:addButton():setText("v"):setSize(3,3):setBackground(colors.gray):setForeground(colors.lightGray)

        local hdgSwitch = remoteFlex:addFrame():setBackground(colors.black):setSize(3,3)
        hdgSwitch:addLabel():setBackground(colors.black):setSize(3,1):setForeground(colors.white):setText("HDG")
        hdgSwitch:addLabel():setBackground(colors.black):setSize(3,1):setForeground(colors.white):setText("---"):setPosition(1,2)
        local hdgValue = hdgSwitch:addLabel():setBackground(colors.black):setSize(3,1):setForeground(colors.white):setText("1"):setPosition(1,3)

        altUp:onClick(function()
            incrementVector("y", getVectorIncrement())
        end)
        altDown:onClick(function ()
            incrementVector("y", -getVectorIncrement())
        end)

        thrustForward:onClick(function ()
            incrementVector("z", getVectorIncrement())
        end)
        thrustBackward:onClick(function ()
            incrementVector("z", -getVectorIncrement())
        end)

        latLeft:onClick(function ()
            incrementVector("x", -getVectorIncrement())
        end)
        latRight:onClick(function ()
            incrementVector("x", getVectorIncrement())
        end)

        hdgLeft:onClick(function ()
            incrementHeading(-getHeadingIncrement())
        end)
        hdgRight:onClick(function ()
            incrementHeading(getHeadingIncrement())
        end)

        vecSwitch:onClick(function ()
            switchIncrement("vector")
            vecValue:setText(getVectorIncrement())
        end)
        hdgSwitch:onClick(function ()
            switchIncrement("heading")
            hdgValue:setText(getHeadingIncrement())
        end)
        
        reset:onClick(function(self,event,button,x,y)
            if button == 1 then
                resetVector()
            elseif button == 2 then
                resetHeading()
            end
        end)

        local currentFlightVector = api.rc.getFlightVector()
        rcVector.x = currentFlightVector.x
        rcVector.y = currentFlightVector.y
        rcVector.z = currentFlightVector.z
        rcHeading = currentFlightVector.r

        vectorLabel:setText(rcVector.x .. " " .. rcVector.y .. " " .. rcVector.z)
        headingLabel:setText(rcHeading)

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

return rc
