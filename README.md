# 🍅 waybar-pomodoro

A simple Pomodoro timer for [Waybar](https://github.com/Alexays/Waybar) on [Omarchy](https://omarchy.org/) Linux.

![demo](https://img.shields.io/badge/waybar-pomodoro-red?style=flat-square)

## Features

- 🍅 **25/5/15** Pomodoro technique (25min work, 5min short break, 15min long break)
- ⏸️ Pause/resume support
- 🔔 Desktop notifications with sound
- 🎨 Color-coded states (work=red, break=green/blue, paused=yellow)
- 🖱️ Full mouse control from waybar
- 😴 Auto-stop on laptop lid close/sleep/hibernate

![screenshot-2026-01-27_20-06-33](https://github.com/gmaxxxie/waybary-pomodoro/tree/master/pic/screenshot-2026-01-27_20-06-33.png)

![screenshot-2026-01-27_20-06-45](https://github.com/gmaxxxie/waybary-pomodoro/tree/master/pic/screenshot-2026-01-27_20-06-45.png)

![screenshot-2026-01-27_20-07-01](https://github.com/gmaxxxie/waybary-pomodoro/tree/master/pic/screenshot-2026-01-27_20-07-01.png)

![screenshot-2026-01-27_20-07-21](https://github.com/gmaxxxie/waybary-pomodoro/tree/master/pic/screenshot-2026-01-27_20-07-21.png)



## Installation

```bash
git clone https://github.com/punkpeye/waybar-pomodoro.git
cd waybar-pomodoro
./install.sh
```

## Manual Setup

### 1. Add module to waybar config

Add to your `~/.config/waybar/config.jsonc`:

```jsonc
"modules-center": ["clock", "custom/pomodoro", ...],

"custom/pomodoro": {
  "format": "{}",
  "exec": "omarchy-pomodoro-status",
  "return-type": "json",
  "interval": 1,
  "signal": 10,
  "on-click": "omarchy-pomodoro toggle",
  "on-click-right": "omarchy-pomodoro stop",
  "on-click-middle": "omarchy-pomodoro skip"
}
```

### 2. Add styles

Add to your `~/.config/waybar/style.css`:

```css
#custom-pomodoro {
  min-width: 60px;
  margin: 0 7.5px;
}

#custom-pomodoro.idle {
  min-width: 0;
  opacity: 0.6;
}

#custom-pomodoro.work {
  color: #d14d41;
}

#custom-pomodoro.short_break {
  color: #879a39;
}

#custom-pomodoro.long_break {
  color: #4385be;
}

#custom-pomodoro.paused {
  color: #d0a215;
}
```

### 3. Restart waybar

```bash
omarchy-restart-waybar
# or: killall waybar && waybar &
```

## Usage

| Action | Waybar | Command |
|--------|--------|---------|
| Start/Pause | Left click 🍅 | `omarchy-pomodoro toggle` |
| Stop | Right click | `omarchy-pomodoro stop` |
| Skip phase | Middle click | `omarchy-pomodoro skip` |
| Reset | - | `omarchy-pomodoro reset` |

## States

| State | Icon | Color |
|-------|------|-------|
| Idle | 🍅 | Gray (60% opacity) |
| Work | 🍅 24:59 | Red |
| Short Break | ☕ 04:59 | Green |
| Long Break | 🌴 14:59 | Blue |
| Paused | 🍅 24:59 ⏸ | Yellow |

## Configuration

Edit `~/.local/bin/omarchy-pomodoro` to customize:

```bash
WORK_DURATION=$((25 * 60))      # 25 minutes
SHORT_BREAK=$((5 * 60))         # 5 minutes
LONG_BREAK=$((15 * 60))         # 15 minutes
POMODOROS_UNTIL_LONG=4          # Long break after 4 pomodoros
```

## Sleep/Hibernate Hook

The timer automatically stops when your laptop goes to sleep or hibernates. To enable this feature, install the systemd sleep hook:

```bash
sudo cp systemd/pomodoro-sleep-hook /lib/systemd/system-sleep/
sudo chmod +x /lib/systemd/system-sleep/pomodoro-sleep-hook
```

## License

MIT
