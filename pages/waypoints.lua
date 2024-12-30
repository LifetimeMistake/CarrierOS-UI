local waypoints = {}
local basalt = require("/apis/basalt") -- we need basalt here

function waypoints.page(main, buttonsFlex, api)
    local screenWidth, screenHeight = main:getSize()

    local mainPageButton = buttonsFlex:addButton()
    mainPageButton:setBackground(colors.black)
    mainPageButton:setForeground(colors.white)
    mainPageButton:setText("Waypoints")
    mainPageButton:setSize(15, "self.h")

    mainPageButton:onClick(function(self, event, button, x, y)
        page = main:addFrame()
        page:setSize("parent.w", "parent.h")
        page:setBackground(colors.lightGray)

        local returnButton = page:addButton()
        returnButton:setBackground(colors.red)
        returnButton:setSize(3, 1)
        returnButton:setText("<")

        local bar = page:addFrame()
        bar:setSize("parent.w-3", 1)
        bar:setPosition(4, 1)

        local waypointsPage = page:addFrame()
        waypointsPage:setSize("parent.w", "parent.h-1")
        waypointsPage:setPosition(1, 2)
        waypointsPage:setBackground(colors.lightGray)

        local searchFlex = waypointsPage:addFlexbox()
        searchFlex:setPosition(2,2)
        searchFlex:setSize("parent.w-2", 3)
        searchFlex:setWrap("wrap")
        searchFlex:setBackground(colors.lightGray)

        local searchBar = searchFlex:addInput()
        searchBar:setDefaultText("Search for waypoints...", colors.gray, colors.black)
        searchBar:setPosition(2, 2)
        searchBar:setSize(24, 1)
        searchBar:setForeground(colors.white)
        searchBar:setBackground(colors.black)
        searchBar:setBorder(colors.black)

        local searchButton = searchFlex:addButton()
        searchButton:setSize(8, 1)
        searchButton:setText("Search")
        searchButton:setForeground(colors.white)
        searchButton:setBackground(colors.blue)
        searchButton:setHorizontalAlign("center")

        local addButton = searchFlex:addButton()
        addButton:setSize(5, 1)
        addButton:setText("Add")
        addButton:setForeground(colors.white)
        addButton:setBackground(colors.green)
        addButton:setHorizontalAlign("center")

        local waypointList = waypointsPage:addFrame()
        waypointList:setPosition(2,4)
        if (screenWidth < 30) then
            waypointList:setPosition(2,6)
        end
        waypointList:setSize("parent.w-2", 14)

        local waypointFlex = waypointList:addFlexbox("gaga")
        waypointFlex:setSize("parent.w", "parent.h")
        waypointFlex:setBackground(colors.lightGray)
        waypointFlex:setWrap("wrap")

        local editBox = waypointsPage:addFrame():hide()
        editBox:setPosition(5, 5)
        editBox:setSize("parent.w-8", "parent.h-6")
        editBox:setBackground(colors.black)
        editBox:setZIndex(25)

        local editBoxFlex = editBox:addFlexbox()
        editBoxFlex:setSize("parent.w", "parent.h-1")
        editBoxFlex:setBackground(colors.black)
        editBoxFlex:setWrap("wrap")
        editBoxFlex:setJustifyContent("center")
        editBoxFlex:setPosition(1, 2)

        local idHolder = editBox:addInput():setInputType("number"):hide()
        
        local nameEditInput = editBoxFlex:addInput()
        nameEditInput:setDefaultText("New waypoint", colors.lightGray, colors.gray)
        nameEditInput:setBackground(colors.gray):setForeground(colors.white)

        editBoxFlex:addBreak()

        local xEditInput = editBoxFlex:addInput():setInputType("number")
        xEditInput:setDefaultText("X", colors.lightGray, colors.gray)
        xEditInput:setBackground(colors.gray):setForeground(colors.white)
        
        local yEditInput = editBoxFlex:addInput():setInputType("number")
        yEditInput:setDefaultText("Y", colors.lightGray, colors.gray)
        yEditInput:setBackground(colors.gray):setForeground(colors.white)
        
        local zEditInput = editBoxFlex:addInput():setInputType("number")
        zEditInput:setDefaultText("Z", colors.lightGray, colors.gray)
        zEditInput:setBackground(colors.gray):setForeground(colors.white)
       
        editBoxFlex:addBreak()

        local headingEditInput = editBoxFlex:addInput():setInputType("number")
        headingEditInput:setDefaultText("Heading", colors.lightGray, colors.gray)
        headingEditInput:setBackground(colors.gray):setForeground(colors.white)

        editBoxFlex:addBreak()

        local editBoxButton = editBoxFlex:addButton()
        editBoxButton:setText("Edit")
        editBoxButton:setSize(5, 1)
        editBoxButton:setForeground(colors.white)
        editBoxButton:setBackground(colors.orange)
        editBoxButton:setHorizontalAlign("center")

        editBoxButton:onClick(function()
            local heading = type(headingEditInput:getValue()) == "number" and headingEditInput:getValue() or nil

            api.waypoints.update(
                tonumber(idHolder:getValue()),
                {
                    name = nameEditInput:getValue(), 
                    pos = { 
                        x = xEditInput:getValue(), 
                        y = yEditInput:getValue(), 
                        z = zEditInput:getValue() 
                    }, 
                    heading = heading
                }
                
            )
            editBox:hide()
        end)

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

            local editButton = waypoint:addButton()
            editButton:setPosition("parent.w-5", "parent.h/2")
            editButton:setSize(4,1)
            editButton:setText("Edit")
            editButton:setBackground(colors.orange)
            editButton:setForeground(colors.white)

            local removeButton = waypoint:addButton()
            removeButton:setPosition("parent.w-2", 1)
            removeButton:setSize(3,1)
            removeButton:setText("X")
            removeButton:setBackground(colors.red)

            removeButton:onClick(function()
                api.waypoints.remove(id)
                waypointFlex:getChild("waypoint" .. id):remove():hide()
            end)

            editButton:onClick(function()
                editBox:show()
                
                xEditInput:setValue(pos.x)
                yEditInput:setValue(pos.y)
                zEditInput:setValue(pos.z)
                headingEditInput:setValue(heading)
                nameEditInput:setValue(name)
                idHolder:setValue(id)
            end)


        end

        local waypoints = api.waypoints.list()
        for _, wp in pairs(waypoints) do
            addWaypoint(wp.id, wp.name, wp.pos, wp.heading)
        end

        local addBox = waypointsPage:addFrame():hide()
        addBox:setPosition(5, 5)
        addBox:setSize("parent.w-8", "parent.h-6")
        addBox:setBackground(colors.black)

        local addBoxFlex = addBox:addFlexbox()
        addBoxFlex:setSize("parent.w", "parent.h-1")
        addBoxFlex:setBackground(colors.black)
        addBoxFlex:setWrap("wrap")
        addBoxFlex:setJustifyContent("center")
        addBoxFlex:setPosition(1, 2)
        
        local nameInput = addBoxFlex:addInput()
        nameInput:setDefaultText("New waypoint", colors.lightGray, colors.gray)
        nameInput:setBackground(colors.gray):setForeground(colors.white)

        addBoxFlex:addBreak()

        local xInput = addBoxFlex:addInput():setInputType("number")
        xInput:setDefaultText("X", colors.lightGray, colors.gray)
        xInput:setBackground(colors.gray):setForeground(colors.white)
        
        local yInput = addBoxFlex:addInput():setInputType("number")
        yInput:setDefaultText("Y", colors.lightGray, colors.gray)
        yInput:setBackground(colors.gray):setForeground(colors.white)
        
        local zInput = addBoxFlex:addInput():setInputType("number")
        zInput:setDefaultText("Z", colors.lightGray, colors.gray)
        zInput:setBackground(colors.gray):setForeground(colors.white)
       
        addBoxFlex:addBreak()

        local headingInput = addBoxFlex:addInput():setInputType("number")
        headingInput:setDefaultText("Heading", colors.lightGray, colors.gray)
        headingInput:setBackground(colors.gray):setForeground(colors.white)

        addBoxFlex:addBreak()

        local addBoxButton = addBoxFlex:addButton()
        addBoxButton:setText("Add")
        addBoxButton:setSize(5, 1)
        addBoxButton:setForeground(colors.white)
        addBoxButton:setBackground(colors.green)
        addBoxButton:setHorizontalAlign("center")

        addBoxButton:onClick(function()
            local heading = type(headingInput:getValue()) == "number" and headingInput:getValue() or nil

            api.waypoints.add(
                nameInput:getValue(), 
                { 
                    x = xInput:getValue(), 
                    y = yInput:getValue(), 
                    z = zInput:getValue() 
                }, 
                heading
            )
            addBox:hide()
        end)


        addButton:onClick(function()
            addBox:show()
            local currentPosition = api.navigation.getInfo().position
            xInput:setValue(math.floor(currentPosition.x))
            yInput:setValue(math.floor(currentPosition.y))
            zInput:setValue(math.floor(currentPosition.z))
            headingInput:setValue("")
            nameInput:setValue("")
        end)
    
        returnButton:onClick(function(self, event, button, x, y)
            page:remove()
            page:remove()
        end)
    end)
end

return waypoints
