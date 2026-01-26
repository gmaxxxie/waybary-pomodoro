#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🍅 Installing waybar-pomodoro..."

cp "$SCRIPT_DIR/bin/omarchy-pomodoro" ~/.local/bin/
cp "$SCRIPT_DIR/bin/omarchy-pomodoro-status" ~/.local/bin/
chmod +x ~/.local/bin/omarchy-pomodoro ~/.local/bin/omarchy-pomodoro-status

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

echo ""
echo "✅ Scripts installed to ~/.local/bin/"
echo "🔄 Run 'omarchy-restart-waybar' after updating config"
