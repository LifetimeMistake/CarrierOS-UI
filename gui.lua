local basalt = require("/apis/basalt") -- we need basalt here
local diagnostics = require("/pages/diagnostics")
local waypoints = require("/pages/waypoints")
local autopilot = require("/pages/autopilot")
local rc = require("/pages/rc")
local navigation = require("/pages/navigation")
local api = require("/apis/api")

local main = basalt.createFrame()

local mainPage = main:addFrame()
mainPage:setBackground(colors.lightGray)
mainPage:setPosition(1,1)
mainPage:setSize("parent.w", "parent.h")

local mainPageBox = mainPage:addFrame()
mainPageBox:setPosition(2,2)
mainPageBox:setSize("parent.w - 2", "parent.h - 2")
mainPageBox:setBorder(colors.black)

local mainPageFlex = mainPageBox:addFlexbox()
mainPageFlex:setPosition(2,2)
mainPageFlex:setSize("parent.w-2", "parent.h-2")
mainPageFlex:setJustifyContent("center")
mainPageFlex:setWrap("wrap")

mainPage:animatePosition(1,1,2)

-- diagnostics

diagnostics.page(main, mainPageFlex, api)

-- navigation

navigation.page(main, mainPageFlex, api)

-- waypoints

waypoints.page(main, mainPageFlex, api)

-- autopilot

autopilot.page(main, mainPageFlex, api)

-- rc

rc.page(main, mainPageFlex, api)

basalt.autoUpdate()