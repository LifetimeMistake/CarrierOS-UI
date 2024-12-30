local autopilot = {}
local basalt = require("/apis/basalt") -- we need basalt here

function autopilot.page(main, buttonsFlex, api)
    local screenWidth, screenHeight = main:getSize()

    local mainPageButton = buttonsFlex:addButton()
    mainPageButton:setBackground(colors.black)
    mainPageButton:setForeground(colors.white)
    mainPageButton:setText("Autopilot")
    mainPageButton:setSize(15, "self.h")

    mainPageButton:onClick(function(self, event, button, x, y)
        page = main:addFrame()
        page:setSize("parent.w", "parent.h")
        page:setBackground(colors.lightGray)

        local autopilotActive = false
        local navActive = false

        local bar = page:addFrame()
        bar:setSize("parent.w-3", 1)
        bar:setPosition(4, 1)

        local autopilotPage = page:addFrame()
        autopilotPage:setSize("parent.w", "parent.h-1")
        autopilotPage:setPosition(1, 2)
        autopilotPage:setBackground(colors.lightGray)

        local buttonFlex = autopilotPage:addFlexbox()
        buttonFlex:setPosition(2,2)
        buttonFlex:setSize("parent.w-2", 5)
        buttonFlex:setWrap("wrap")
        buttonFlex:setBackground(colors.lightGray)

        local apFlex = buttonFlex:addFlexbox()
        apFlex:setWrap("wrap")
        apFlex:setSize(15, 1)
        apFlex:setBackground(colors.lightGray)

        local autopilotCheckbox = apFlex:addButton()
        autopilotCheckbox:setText("")
        autopilotCheckbox:setSize(1,1)
        autopilotCheckbox:setBackground(colors.white)

        local function setApCheckbox(active)
            if active then
                autopilotActive = true
                autopilotCheckbox:setText("X")
                api.autopilot.setEnabled(true)
            else
                autopilotActive = false
                autopilotCheckbox:setText("")
                api.autopilot.setEnabled(false)
            end
        end

        autopilotCheckbox:onClick(function()
            setApCheckbox(not autopilotActive)
        end)

        setApCheckbox(api.autopilot.getEnabled())

        local autopilotLabel = apFlex:addLabel()
        autopilotLabel:setSize(10, 1)
        autopilotLabel:setBackground(colors.lightGray)
        autopilotLabel:setText("Autopilot")

        local navFlex = buttonFlex:addFlexbox()
        navFlex:setWrap("wrap")
        navFlex:setSize(15, 1)
        navFlex:setBackground(colors.lightGray)

        local navCheckbox = navFlex:addButton()
        navCheckbox:setText("X")
        navCheckbox:setSize(1,1)
        navCheckbox:setBackground(colors.white)

        local function setNavCheckbox(active)
            if active then
                navActive = true
                navCheckbox:setText("X")
                api.autopilot.setNavigationEnabled(true)
            else
                navActive = false
                navCheckbox:setText("")
                api.autopilot.setNavigationEnabled(false)
            end
        end

        navCheckbox:onClick(function()
            setNavCheckbox(not navActive)
        end)

        setNavCheckbox(api.autopilot.getNavigationEnabled())

        local navLabel = navFlex:addLabel()
        navLabel:setSize(10, 1)
        navLabel:setBackground(colors.lightGray)
        navLabel:setText("Navigation")

        local addButton = buttonFlex:addButton()
        addButton:setSize(3, 1)
        addButton:setBackground(colors.green)
        addButton:setForeground(colors.white)
        addButton:setText("Add")

        local waypointList = autopilotPage:addFrame()
        waypointList:setPosition(2,7)
        if (screenWidth < 30) then
            waypointList:setPosition(2,6)
        end
        waypointList:setSize("parent.w-2", autopilotPage:getHeight()-buttonFlex:getHeight())

        local waypointFlex = waypointList:addFlexbox("gaga")
        waypointFlex:setSize("parent.w", "parent.h")
        waypointFlex:setBackground(colors.lightGray)
        waypointFlex:setWrap("wrap")

        local function addWaypoint(id, name, pos, heading)
            local waypoint = waypointFlex:addFrame("waypoint" .. id)
            waypoint:setSize("parent.w", "parent.h/2-2")

            waypointFlex:updateLayout()

            local waypointName = waypoint:addLabel()
            waypointName:setPosition(2, 2):setForeground(colors.black)
            waypointName:setText(name)

            local waypointCoords = waypoint:addLabel()
            waypointCoords:setPosition(2, 3):setForeground(colors.white)
            waypointCoords:setText((pos.x or 0) .. " " .. (pos.y or 0) .. " " .. (pos.z or 0))

            if heading then
                local waypointHeading = waypoint:addLabel()
                waypointHeading:setPosition(2, 4):setForeground(colors.white)
                waypointHeading:setText("|H " .. heading .. "|")
            end

            local removeButton = waypoint:addButton()
            removeButton:setPosition("parent.w-2", 1)
            removeButton:setSize(3,1)
            removeButton:setText("X")
            removeButton:setBackground(colors.red)

            removeButton:onClick(function()
                api.autopilot.removeWaypoint(id)
                waypointFlex:getChild("waypoint" .. id):remove():hide()
            end)
        end

        local apWaypoints = api.autopilot.listWaypoints()
        for id, wp in pairs(apWaypoints) do
            addWaypoint(id, wp.name, wp.vector, wp.heading)
        end

        local addBox = autopilotPage:addFrame():hide()
        addBox:setPosition(2, 2)
        addBox:setSize("parent.w-2", "parent.h-2")
        addBox:setBackground(colors.black)

        local addBoxFlex = addBox:addFlexbox()
        addBoxFlex:setSize("parent.w-2", "parent.h-2")
        addBoxFlex:setBackground(colors.black)
        addBoxFlex:setWrap("wrap")
        addBoxFlex:setJustifyContent("center")
        addBoxFlex:setPosition(2, 2)

        local function addBoxWaypoint(id, name, pos, heading)
            local waypoint = addBoxFlex:addFrame("waypoint" .. id)
            waypoint:setSize("parent.w", "parent.h/2-2")

            waypointFlex:updateLayout()

            local waypointName = waypoint:addLabel()
            waypointName:setPosition(2, 2):setForeground(colors.black)
            waypointName:setText(name)

            local waypointCoords = waypoint:addLabel()
            waypointCoords:setPosition(2, 3):setForeground(colors.white)
            waypointCoords:setText((pos.x or 0) .. " " .. (pos.y or 0) .. " " .. (pos.z or 0))

            if heading then
                local waypointHeading = waypoint:addLabel()
                waypointHeading:setPosition(2, 4):setForeground(colors.white)
                waypointHeading:setText("|H " .. heading .. "|")
            end

            local addWaypointButton = waypoint:addButton()
            addWaypointButton:setPosition("parent.w-6", "parent.h/2")
            addWaypointButton:setSize(5,1)
            addWaypointButton:setText("Add")
            addWaypointButton:setBackground(colors.green)
            addWaypointButton:setForeground(colors.white)
            addWaypointButton:setZIndex(25)

            addWaypointButton:onClick(function()
                api.autopilot.addStoredWaypoint(id)
                addBox:hide()
            end)
        end

        addButton:onClick(function()
            addBox:show()
            local waypoints = api.waypoints.list()
            for _, wp in pairs(waypoints) do
                addBoxWaypoint(wp.id, wp.name, wp.pos, wp.heading)
            end
        end)

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

return autopilot
