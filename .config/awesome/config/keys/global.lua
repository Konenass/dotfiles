-- File defining global keyboard bindings
local gears = require('gears')
local awful = require("awful")
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

require('awful.hotkeys_popup.keys')

local modkey = "Mod4"
local alt = "Mod1"
local shift = "Shift"
local ctrl = "Control"
local tab = "Tab"
local app = require("config.apps")



local keys = 
    gears.table.join(
        -- Show hotkeys
        awful.key({modkey}, 's', hotkeys_popup.show_help, {description = 'Show help', group = 'awesome'}),
        
        -- Focus control
        awful.key({alt}, tab,
        function ()
            awful.client.focus.byidx(1)  
            if _G.client.focus then
                _G.client.focus:raise()
            end  
        end,
        {description = 'Focus by next index', group = "client"}),
        awful.key({alt, shift}, tab,
        function ()
            awful.client.focus.byidx(-1)   
            if _G.client.focus then
                _G.client.focus:raise()
            end   
        end,
        {description = 'Focus by previous index', group = "client"}),
        awful.key({ modkey, ctrl }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                end
            end,
        {description = "restore minimized", group = "client"}),

        -- Screen Focus
        awful.key({modkey}, tab,
            function()
                awful.screen.focus_relative(1)
            end,
        {description = "focus next screen", group="screen"}),
        awful.key({modkey, shift}, tab,
            function()
                awful.screen.focus_relative(-1)
            end,
        {description = "focus previous screen", group="screen"}),
        awful.key({modkey}, 'h',
            function()
                awful.client.focus.global_bydirection("left")
            end,
            {description = "focus next window left", group = "client"}
        ),
        awful.key({modkey}, 'l',
            function()
                awful.client.focus.global_bydirection("right")
            end,
            {description = "focus next window right", group = "client"}
        ),
        awful.key({modkey}, 'j',
            function()
                awful.client.focus.global_bydirection("down")
            end,
            {description = "focus next window down", group = "client"}
        ),
        awful.key({modkey}, 'k',
            function()
                awful.client.focus.global_bydirection("up")
            end,
            {description = "focus next window up", group = "client"}
        ),

        -- Shutdown, Reboot, Lcok hotkeys
        awful.key({modkey, 'Shift'}, 'r',
        function()
            awful.spawn('reboot')
        end,
        {description = 'Reboot Computer', group = 'awesome'}
        ),
        awful.key({modkey, 'Shift'}, 's',
        function()
            awful.spawn('shutdown now')
        end,
        {description = 'Shutdown Computer', group = 'awesome'}
        ),
        awful.key({modkey, shift}, 'l',
        function ()
          awful.spawn(app.default.lock)
        end,
        {description = "Lock screen", group = 'awesome'}
        ),

        -- Launchers
        awful.key({modkey}, 'space', 
        function ()
            awful.spawn(app.default.rofi)
        end,
        {description = "Run prompt", group = "launcher"}
        ),
        awful.key({modkey}, 'b',
        function ()
            awful.spawn(app.default.browser)
        end,
        {description = "Lauch browser", group = "launcher"}
        ),
        awful.key({modkey}, 'w', 
        function ()
            awful.spawn(app.default.terminal)
        end,
        {description = "Launch terminal emulator", group = "launcher"}
        ),
        awful.key({modkey}, 'e', 
        function ()
            awful.spawn(app.default.editor)
        end,
        {description = "Launch editor", group = "launcher"}
        ),
        awful.key({modkey, alt}, 'e',
            function()
                awful.spawn(app.default.files)
            end,
        {description = "Launch file manager", group = "launcher"}
        ),

        -- Awesome control
        awful.key({modkey, ctrl}, 'r', _G.awesome.restart, {description = 'Reload awesome', group = 'awesome'}),
        awful.key({modkey, ctrl}, 'q', _G.awesome.quit, {description = 'Quit awesome', group = 'awesome'}),

        awful.key({}, 'Print', function() awful.spawn('flameshot gui') end, {description = ' Take screenshot', group = 'awesome'}  )
      
            )
return keys
