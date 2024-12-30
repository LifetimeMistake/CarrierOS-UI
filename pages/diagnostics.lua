local diagnostics = {}
local basalt = require("/apis/basalt") -- we need basalt here

function diagnostics.page(main, buttonsFlex, api)
    local screenWidth, screenHeight = main:getSize()

    local mainPageButton = buttonsFlex:addButton()
    mainPageButton:setBackground(colors.black)
    mainPageButton:setForeground(colors.white)
    mainPageButton:setText("Diagnostics")
    mainPageButton:setSize(15, "self.h")

    mainPageButton:onClick(function(self, event, button, x, y)
        page = main:addFrame("diagnostics")
        page:setSize("parent.w", "parent.h")
        page:setBackground(colors.lightGray)

        -- thrusters

        local thrustersPage = page:addFrame()
        thrustersPage:setPosition(1, 2)
        thrustersPage:setSize("parent.w", "parent.h - 1")
        thrustersPage:setBackground(colors.lightGray)

        local thrustersColumn1 = thrustersPage:addFrame():setBackground(colors.lightGray)
        thrustersColumn1:setSize("parent.w/2", "parent.h")
        if screenWidth < 30 then
            thrustersColumn1:setSize("parent.w", "parent.h")
        end
        thrustersColumn1:setBorder(colors.blue)

        local thrustersColumn2 = thrustersPage:addFrame():setBackground(colors.lightGray)
        thrustersColumn2:setSize("parent.w/2-1", "parent.h")
        thrustersColumn2:setPosition("parent.w/2+1", 1)
        if screenWidth < 30 then
            thrustersColumn2:setSize("parent.w", "parent.h")
            thrustersColumn2:setPosition(1, 1)
            thrustersColumn2:hide()
        end
        thrustersColumn2:setBorder(colors.red)

        if screenWidth < 30 then
            local switchSideButton = thrustersPage:addButton()
            switchSideButton:setSize(3, 1)
            switchSideButton:setBackground(colors.red)
            switchSideButton:setForeground(colors.white)
            switchSideButton:setPosition("parent.w-3", "parent.h-1")
            switchSideButton:setText(">") 
            switchSideButton:setZIndex(25)

            switchSideButton:onClick(function(self, event, button, x, y)
                if thrustersColumn1:isVisible() then
                    thrustersColumn1:hide()
                    thrustersColumn2:show()
                    switchSideButton:setPosition(2, "parent.h-1")
                    switchSideButton:setText("<")
                    switchSideButton:setBackground(colors.blue)
                elseif thrustersColumn2:isVisible() then
                    thrustersColumn1:show()
                    thrustersColumn2:hide()
                    switchSideButton:setPosition("parent.w-3", "parent.h-1")
                    switchSideButton:setText(">")
                    switchSideButton:setBackground(colors.red)
                end
            end)
        end

        local thrustersColumn1Flex = thrustersColumn1:addFlexbox():setBackground(colors.lightGray)
        thrustersColumn1Flex:setPosition(2, 2)
        thrustersColumn1Flex:setSize("parent.w-2", "parent.h-3")
        thrustersColumn1Flex:setWrap("wrap")

        local thrustersColumn2Flex = thrustersColumn2:addFlexbox():setBackground(colors.lightGray)
        thrustersColumn2Flex:setPosition(2, 2)
        thrustersColumn2Flex:setSize("parent.w-2", "parent.h-3")
        thrustersColumn2Flex:setWrap("wrap")

        -- Updated Left Thrusters Variables
        local mainFrontLeftLB, mainFrontLeftPB
        local corrFrontLeftLB, corrFrontLeftPB
        local thrustLeftLB, thrustLeftPB
        local corrBackLeftLB, corrBackLeftPB
        local mainBackLeftLB, mainBackLeftPB

        -- Create Left Thrusters
        local mainFrontLeft = thrustersColumn1Flex:addFrame():setBackground(colors.lightGray)
        mainFrontLeft:setSize("parent.w", 2)
        mainFrontLeftLB = mainFrontLeft:addLabel():setBackground(colors.lightGray):setText("Main Front Left: 72%") -- Random value
        mainFrontLeftPB = mainFrontLeft:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(72)

        local corrFrontLeft = thrustersColumn1Flex:addFrame():setBackground(colors.lightGray)
        corrFrontLeft:setSize("parent.w", 2)
        corrFrontLeftLB = corrFrontLeft:addLabel():setBackground(colors.lightGray):setText("Corr Front Left: 54%")
        corrFrontLeftPB = corrFrontLeft:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(54)

        local thrustLeft = thrustersColumn1Flex:addFrame():setBackground(colors.lightGray)
        thrustLeft:setSize("parent.w", 2)
        thrustLeftLB = thrustLeft:addLabel():setBackground(colors.lightGray):setText("Thrust Left: 85%") -- Random value
        thrustLeftPB = thrustLeft:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(85)

        local corrBackLeft = thrustersColumn1Flex:addFrame():setBackground(colors.lightGray)
        corrBackLeft:setSize("parent.w", 2)
        corrBackLeftLB = corrBackLeft:addLabel():setBackground(colors.lightGray):setText("Corr Back Left: 39%") -- Random value
        corrBackLeftPB = corrBackLeft:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(39)

        local mainBackLeft = thrustersColumn1Flex:addFrame():setBackground(colors.lightGray)
        mainBackLeft:setSize("parent.w", 2)
        mainBackLeftLB = mainBackLeft:addLabel():setBackground(colors.lightGray):setText("Main Back Left: 99%") -- Random value
        mainBackLeftPB = mainBackLeft:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(99)

        -- Updated Right Thrusters Variables
        local mainFrontRightLB, mainFrontRightPB
        local corrFrontRightLB, corrFrontRightPB
        local thrustRightLB, thrustRightPB
        local corrBackRightLB, corrBackRightPB
        local mainBackRightLB, mainBackRightPB

        -- Create Right Thrusters
        local mainFrontRight = thrustersColumn2Flex:addFrame():setBackground(colors.lightGray)
        mainFrontRight:setSize("parent.w", 2)
        mainFrontRightLB = mainFrontRight:addLabel():setBackground(colors.lightGray):setText("Main Front Right: 66%") -- Random value
        mainFrontRightPB = mainFrontRight:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(66)

        local corrFrontRight = thrustersColumn2Flex:addFrame():setBackground(colors.lightGray)
        corrFrontRight:setSize("parent.w", 2)
        corrFrontRightLB = corrFrontRight:addLabel():setBackground(colors.lightGray):setText("Corr Front Right: 28%") -- Random value
        corrFrontRightPB = corrFrontRight:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(28)

        local thrustRight = thrustersColumn2Flex:addFrame():setBackground(colors.lightGray)
        thrustRight:setSize("parent.w", 2)
        thrustRightLB = thrustRight:addLabel():setBackground(colors.lightGray):setText("Thrust Right: 90%") -- Random value
        thrustRightPB = thrustRight:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(90)

        local corrBackRight = thrustersColumn2Flex:addFrame():setBackground(colors.lightGray)
        corrBackRight:setSize("parent.w", 2)
        corrBackRightLB = corrBackRight:addLabel():setBackground(colors.lightGray):setText("Corr Back Right: 3%") -- Random value
        corrBackRightPB = corrBackRight:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(3)

        local mainBackRight = thrustersColumn2Flex:addFrame():setBackground(colors.lightGray)
        mainBackRight:setSize("parent.w", 2)
        mainBackRightLB = mainBackRight:addLabel():setBackground(colors.lightGray):setText("Main Back Right: 77%") -- Random value
        mainBackRightPB = mainBackRight:addProgressbar()
            :setPosition(1, 2)
            :setSize("parent.w", 1)
            :setBackgroundSymbol("-")
            :setBackground(colors.gray)
            :setProgress(77)

        local thrustersList = {
            {
                name = "main_front_left",
                label = mainFrontLeftLB,
                progressbar = mainFrontLeftPB
            },
            {
                name = "corr_front_left",
                label = corrFrontLeftLB,
                progressbar = corrFrontLeftPB
            },
            {
                name = "thrust_left",
                label = thrustLeftLB,
                progressbar = thrustLeftPB
            },
            {
                name = "corr_back_left",
                label = corrBackLeftLB,
                progressbar = corrBackLeftPB
            },
            {
                name = "main_back_left",
                label = mainBackLeftLB,
                progressbar = mainBackLeftPB
            },
            {
                name = "main_front_right",
                label = mainFrontRightLB,
                progressbar = mainFrontRightPB
            },
            {
                name = "corr_front_right",
                label = corrFrontRightLB,
                progressbar = corrFrontRightPB
            },
            {
                name = "thrust_right",
                label = thrustRightLB,
                progressbar = thrustRightPB
            },
            {
                name = "corr_back_right",
                label = corrBackRightLB,
                progressbar = corrBackRightPB
            },
            {
                name = "main_back_right",
                label = mainBackRightLB,
                progressbar = mainBackRightPB
            }
        }
        
        -- stabilizer

        local stabilizerPage = page:addFrame():hide()
        stabilizerPage:setPosition(1, 2)
        stabilizerPage:setSize("parent.w", "parent.h - 1")
        stabilizerPage:setBackground(colors.lightGray)

        local stabilizerFlex = stabilizerPage:addFlexbox()
        stabilizerFlex:setSize("parent.w-2", "parent.h-2")
        stabilizerFlex:setPosition(2,2)
        stabilizerFlex:setWrap("wrap")
        stabilizerFlex:setBackground(colors.lightGray)

        if screenWidth < 30 then
            local stabilizerScroll = stabilizerPage:addScrollbar()
            stabilizerScroll:setPosition("parent.w", 1)
            stabilizerScroll:setSize(1,"parent.h")
            stabilizerScroll:setScrollAmount(stabilizerPage:getHeight()-3)

            stabilizerScroll:onChange(function(self, _, value)
                stabilizerFlex:setOffset(0, value-1)
            end)
        end

        local weights = stabilizerFlex:addFlexbox()
        weights:setPosition(2,2)
        weights:setSize(20, 7)
        weights:setWrap("wrap")
        weights:setSpacing(0)
        weights:setBackground(colors.lightGray)

        local weightsLabel = weights:addLabel()
        weightsLabel:setText("Weights"):setSize("parent.w", 1)
        weights:addLabel():setText(""):setSize("parent.w", 1)
        local mainFrontLeftWeight = weights:addLabel()
        mainFrontLeftWeight:setText("FRONT LEFT: 2.5"):setSize("parent.w", 1)
        local mainBackLeftWeight = weights:addLabel()
        mainBackLeftWeight:setText("BACK LEFT: 6"):setSize("parent.w", 1)
        local mainFrontRightWeight = weights:addLabel()
        mainFrontRightWeight:setText("FRONT RIGHT: 1.2"):setSize("parent.w", 1)
        local mainBackRightWeight = weights:addLabel()
        mainBackRightWeight:setText("BACK RIGHT: 3.4"):setSize("parent.w", 1)

        local targetVector = stabilizerFlex:addFlexbox()
        targetVector:setSize(20, 7)
        targetVector:setWrap("wrap")
        targetVector:setSpacing(0)
        targetVector:setBackground(colors.lightGray)

        local vectorLabel = targetVector:addLabel()
        vectorLabel:setText("Target Vector"):setSize("parent.w", 1)
        targetVector:addLabel():setText(""):setSize("parent.w", 1)
        local tX = targetVector:addLabel()
        tX:setText("X: 150.3"):setSize("parent.w", 1)
        local tY = targetVector:addLabel()
        tY:setText("Y: 12"):setSize("parent.w", 1)
        local tZ = targetVector:addLabel()
        tZ:setText("Z: 10.3"):setSize("parent.w", 1)

        local forceDiff = stabilizerFlex:addFlexbox()
        forceDiff:setSize(20, 7)
        forceDiff:setWrap("wrap")
        forceDiff:setSpacing(0)
        forceDiff:setBackground(colors.lightGray)

        local diffLabel = forceDiff:addLabel()
        diffLabel:setText("Force Diff"):setSize("parent.w", 1)
        forceDiff:addLabel():setText(""):setSize("parent.w", 1)
        local fX = forceDiff:addLabel()
        fX:setText("X: 5.245 kN"):setSize("parent.w", 1)
        local fY = forceDiff:addLabel()
        fY:setText("Y: 2.023 kN"):setSize("parent.w", 1)
        local fZ = forceDiff:addLabel()
        fZ:setText("Z: 7.112 kN"):setSize("parent.w", 1)

        local kVector = stabilizerFlex:addFlexbox()
        kVector:setSize(20, 7)
        kVector:setWrap("wrap")
        kVector:setSpacing(0)
        kVector:setBackground(colors.lightGray)

        local kVectorLabel = kVector:addLabel()
        kVectorLabel:setText("K Vector"):setSize("parent.w", 1)
        kVector:addLabel():setText(""):setSize("parent.w", 1)
        local kX = kVector:addLabel()
        kX:setText("X: 3"):setSize("parent.w", 1)
        local kY = kVector:addLabel()
        kY:setText("Y: 1"):setSize("parent.w", 1)
        local kZ = kVector:addLabel()
        kZ:setText("Z: 6"):setSize("parent.w", 1)
        
        -- autopilot

        local autopilotPage = page:addFrame():hide()
        autopilotPage:setPosition(1, 2)
        autopilotPage:setSize("parent.w", "parent.h - 1")
        autopilotPage:setBackground(colors.lightGray)

        local targetPositionBox = autopilotPage:addFrame()
        targetPositionBox:setPosition(2,2)
        targetPositionBox:setSize("parent.w-2", 6)
        targetPositionBox:setBorder(colors.black)

        local targetPosition = targetPositionBox:addLabel()
        targetPosition:setText("Target position:"):setForeground(colors.lightGray)
        targetPosition:setPosition(2, 2)

        local targetPositionCoords = targetPositionBox:addLabel()
        targetPositionCoords:setText("150, 74, -1200"):setForeground(colors.white)
        targetPositionCoords:setPosition(2, 3)

        local strategyLabel = targetPositionBox:addLabel():setText("Strategy: HOLD"):setForeground(colors.white):setPosition(2,5)

        local haltFlex = autopilotPage:addFlexbox():setSize("parent.w-2", 1):setPosition(2,9):setBackground(colors.lightGray)

        local haltButton = haltFlex:addButton():setText("HALT"):setBackground(colors.red):setForeground(colors.white):setSize(6,1)
        local unhaltButton = haltFlex:addButton():setText("UNHALT"):setBackground(colors.orange):setForeground(colors.white):setSize(8,1)

        haltButton:onClick(function ()
            api.debug.halt()
        end)

        unhaltButton:onClick(function ()
            api.debug.unhalt()
        end)

        autopilotPage:addLabel():setText("Route waypoints:"):setPosition(2,11)

        local waypointList = autopilotPage:addFrame()
        waypointList:setPosition(2,12)
        waypointList:setSize("parent.w-2", 9)

        local waypointFlex = waypointList:addFlexbox()
        waypointFlex:setSize("parent.w", "parent.h")
        waypointFlex:setBackground(colors.lightGray)
        waypointFlex:setWrap("wrap")

        local waypoints = api.autopilot.listWaypoints()
        for _, wp in pairs(waypoints) do
            local waypoint = waypointFlex:addMovableFrame("waypoint")
            waypoint:setSize("parent.w", "parent.h/2")

            waypointFlex:updateLayout()

            local waypointName = waypoint:addLabel()
            waypointName:setPosition(2, 2):setForeground(colors.black)
            waypointName:setText(wp.name)

            local waypointCoords = waypoint:addLabel()
            waypointCoords:setPosition(2, 3):setForeground(colors.white)
            waypointCoords:setText((wp.vector.x or 0) .. " " .. (wp.vector.y or 0) .. " " .. (wp.vector.z or 0))

            if wp.heading then
                local waypointHeading = waypoint:addLabel()
                waypointHeading:setPosition(2, 4):setForeground(colors.white)
                waypointHeading:setText("|H " .. wp.heading .. "|")
            end
        end

        local function updatePageTask()
            while true do
                local apiThrusters = api.debug.getThrusterInfo()
    
                local thrustersLookup = {}
                for _, thruster in pairs(apiThrusters) do
                    thrustersLookup[thruster.name] = { level = thruster.level, weight = thruster.weight }
                end

                for _, localThruster in pairs(thrustersList) do
                    local apiData = thrustersLookup[localThruster.name]
                    if apiData then
                        localThruster.label:setText(localThruster.name .. ": " .. math.floor(apiData.level*100) .. "%")
                        localThruster.progressbar:setProgress(apiData.level*100)  
                    end
                end
    
                mainFrontLeftWeight:setText("FRONT LEFT: " .. (thrustersLookup["main_front_left"].weight or 0))
                mainBackLeftWeight:setText("BACK LEFT: " .. (thrustersLookup["main_back_left"].weight or 0))
                mainFrontRightWeight:setText("FRONT RIGHT: " .. (thrustersLookup["main_front_right"].weight or 0))
                mainBackRightWeight:setText("BACK RIGHT: " .. (thrustersLookup["main_back_right"].weight or 0))
    
                local apiStabilizer = api.debug.getStabilizerState()
    
                tX:setText("X: " .. math.floor(apiStabilizer.target_vector.x*1000)/10)
                tY:setText("Y: " .. math.floor(apiStabilizer.target_vector.y*1000)/10)
                tZ:setText("Z: " .. math.floor(apiStabilizer.target_vector.z*1000)/10)
    
                fX:setText("X: " .. math.floor(apiStabilizer.force_diff.x*1000)/10)
                fY:setText("Y: " .. math.floor(apiStabilizer.force_diff.y*1000)/10)
                fZ:setText("Z: " .. math.floor(apiStabilizer.force_diff.z*1000)/10)
    
                kX:setText("X: " .. math.floor(apiStabilizer.k_vector.x*1000)/10)
                kY:setText("Y: " .. math.floor(apiStabilizer.k_vector.y*1000)/10)
                kZ:setText("Z: " .. math.floor(apiStabilizer.k_vector.z*1000)/10)
    
                local targetPosition = api.autopilot.getTargetPosition()
    
                targetPositionCoords:setText(math.floor(targetPosition.x*10)/10 .. " " .. math.floor(targetPosition.y*10)/10 .. " " .. math.floor(targetPosition.z*10)/10)
    
                local strategy = api.autopilot.getStrategy()
                strategyLabel:setText("Strategy: " .. strategy)

                waypointFlex:updateLayout()

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

        -- menubar navigation

        local subPages = {
            thrustersPage,
            stabilizerPage,
            autopilotPage
        }

        local function openSubPage(id)
            if (subPages[id] ~= nil) then
                for k, v in pairs(subPages) do
                    v:hide()
                end
                subPages[id]:show()
            end
        end

        local menubar = page:addMenubar()
        menubar:setScrollable()
        menubar:setPosition(4, 1)
        menubar:setSize("parent.w-3", 1)
        menubar:addItem("Thrusters")
        menubar:addItem("Stabilizer")
        menubar:addItem("Autopilot")
        menubar:onChange(function(self, val)
            openSubPage(self:getItemIndex())
        end)
        
        updatePageThread:start(updatePageTask)
    end)
end

return diagnostics
