local fs = require('gears.filesystem')

return {
    -- Default apps
    default = {
        terminal = 'kitty',
        rofi = 'rofi -show combi -combi-modes "window,run" -modes combi',
        lock = 'lxlock',
        --lock = 'i3lock -c 282828',
        screenshot = 'flameshot gui -p ~/Pictures',
        browser = 'firefox',
        editor = 'emacsclient -c -a \'emacs\'', -- gui text editor
        files = 'pcmanfm'
    },

    -- Apps to run at startup
    startup = {
        --'picom --config ~/.config/picom/picom.conf',
        'nm-applet',
        'pasystray',
        'flameshot',
        'steam -silent',
        'discord',
        '~/.config/awesome/config/awful-spawn.sh'
    }
}
