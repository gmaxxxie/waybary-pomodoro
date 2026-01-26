# 🍅 waybar-pomodoro

A simple Pomodoro timer for [Waybar](https://github.com/Alexays/Waybar) on [Omarchy](https://omarchy.org/) Linux.

![demo](https://img.shields.io/badge/waybar-pomodoro-red?style=flat-square)

## Features

- 🍅 **25/5/15** Pomodoro technique (25min work, 5min short break, 15min long break)
- ⏸️ Pause/resume support
- 🔔 Desktop notifications with sound
- 🎨 Color-coded states (work=red, break=green/blue, paused=yellow)
- 🖱️ Full mouse control from waybar

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

## License

MIT
