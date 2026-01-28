#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🍅 Installing waybar-pomodoro..."

cp "$SCRIPT_DIR/bin/omarchy-pomodoro" ~/.local/bin/
cp "$SCRIPT_DIR/bin/omarchy-pomodoro-status" ~/.local/bin/
cp "$SCRIPT_DIR/bin/pomodoro-lid-monitor" ~/.local/bin/
chmod +x ~/.local/bin/omarchy-pomodoro ~/.local/bin/omarchy-pomodoro-status ~/.local/bin/pomodoro-lid-monitor

WAYBAR_CONFIG=~/.config/waybar/config.jsonc
WAYBAR_STYLE=~/.config/waybar/style.css

if ! grep -q "custom/pomodoro" "$WAYBAR_CONFIG" 2>/dev/null; then
    echo "📝 Please add the following to your waybar config.jsonc:"
    echo ""
    cat "$SCRIPT_DIR/config/waybar-module.jsonc"
    echo ""
    echo "And add \"custom/pomodoro\" to your modules-center or modules-right."
fi

if ! grep -q "#custom-pomodoro" "$WAYBAR_STYLE" 2>/dev/null; then
    echo ""
    echo "📝 Please add the following to your waybar style.css:"
    echo ""
    cat "$SCRIPT_DIR/config/waybar-style.css"
fi

# Install systemd sleep hook (requires sudo)
SLEEP_HOOK_SRC="$SCRIPT_DIR/systemd/pomodoro-sleep-hook"
SLEEP_HOOK_DST="/lib/systemd/system-sleep/pomodoro-sleep-hook"

if [[ -f "$SLEEP_HOOK_SRC" ]]; then
    if [[ -w "/lib/systemd/system-sleep/" ]] || [[ $EUID -eq 0 ]]; then
        cp "$SLEEP_HOOK_SRC" "$SLEEP_HOOK_DST"
        chmod +x "$SLEEP_HOOK_DST"
        echo "😴 Sleep hook installed (timer stops on suspend/hibernate)"
    else
        echo ""
        echo "📝 Optional: Install sleep hook to stop timer on suspend/hibernate:"
        echo "   sudo cp $SLEEP_HOOK_SRC $SLEEP_HOOK_DST"
        echo "   sudo chmod +x $SLEEP_HOOK_DST"
    fi
fi

mkdir -p ~/.config/systemd/user
cp "$SCRIPT_DIR/systemd/pomodoro-lid-monitor.service" ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now pomodoro-lid-monitor.service 2>/dev/null || true
echo "😴 Lid monitor service installed (timer stops on lid close)"

echo ""
echo "✅ Scripts installed to ~/.local/bin/"
echo "🔄 Run 'omarchy-restart-waybar' after updating config"
