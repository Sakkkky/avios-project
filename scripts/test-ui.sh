#!/bin/bash
# AVIOS UI Test Server
# Quickly test the AVIOS desktop environment without building the full ISO

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
UI_DIR="$PROJECT_ROOT/ui"

echo "======================================"
echo "   AVIOS UI Test Server"
echo "======================================"
echo ""

# Check if UI directory exists
if [ ! -d "$UI_DIR" ]; then
    echo "ERROR: UI directory not found at $UI_DIR"
    exit 1
fi

# Check for Python
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed"
    echo "Please install Python 3 to run the test server"
    exit 1
fi

echo "Starting AVIOS UI test server..."
echo ""
echo "UI Directory: $UI_DIR"
echo "Server Port: 8080"
echo ""
echo "======================================"
echo ""
echo "  Open in your browser:"
echo "  http://localhost:8080/desktop.html"
echo ""
echo "======================================"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

cd "$UI_DIR"
python3 -m http.server 8080
