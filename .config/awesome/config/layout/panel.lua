local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local TagList = require('widget.tag-list')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')

local systray = wibox.widget.systray()
  systray:set_horizontal(true)
  systray:set_base_size(20)
  systray.forced_height = 20

local clock = wibox.widget.textclovc()
--local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

-- Indicate which layout is used
local LayoutBox = function(s)
    local layoutBox = clickable_container(awful.widget.layoutbox(s))
    layoutBox:buttons(
      awful.util.table.join(
        awful.button(
          {},
          1,
          function()
            awful.layout.inc(1)
          end
        ),
        awful.button(
          {},
          3,
          function()
            awful.layout.inc(-1)
          end
        ),
        awful.button(
          {},
          4,
          function()
            awful.layout.inc(1)
          end
        ),
        awful.button(
          {},
          5,
          function()
            awful.layout.inc(-1)
          end
        )
      )
    )
    return layoutBox
end

local TopPanel = function(s)
  
    local panel =
    wibox(
    {
      ontop = true,
      screen = s,
      height = dpi(32),
      width = s.geometry.width,
      x = s.geometry.x,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.background.hue_800,
      fg = beautiful.fg_normal,
      struts = {
        top = dpi(32)
      }
    }
    )

    panel:struts(
      {
        top = dpi(32)
      }
    )

    panel:setup {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        -- Create a taglist widget
        TagList(s),
        TaskList(s),
        add_button
      },
      nil,
      {
        layout = wibox.layout.fixed.horizontal,
        wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3)),
        -- Layout box
        LayoutBox(s),
        -- Clock
        clock_widget,
      }
    }

  return panel
end

return TopPanel