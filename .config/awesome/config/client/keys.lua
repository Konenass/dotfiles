local awful = require('awful')
--require('awful.autofocus')
local modkey = require('config.keys.global').modKey

local clientKeys =
  awful.util.table.join(
    awful.key(
      {modkey},
      'm',
      function(c)
        c.maximized = not c.maximized
        c:raise()
      end,
      {description = 'Maximize window', group = 'client'}
    ),
    awful.key(
      {modkey},
      'c',
      function(c)
        c:kill()
      end,
      {description = 'Close window', group = 'client'}
    ),
    awful.key({modkey}, 'o',
      function(c)
        c:move_to_screen()
      end,
      {description = "Move to next screen", group = 'client'}
    ),
    awful.key({modkey}, 't',
      function(c)
        c.ontop =not c.ontop
      end,
      {description = "Keep on top", group = 'client'}
    ),
    awful.key({ modkey,           }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "client"})
  )


return clientKeys
