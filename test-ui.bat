@echo off
REM AVIOS UI Test Server for Windows
REM Test the AVIOS interface without building the full ISO

echo ========================================
echo    AVIOS UI Test Server
echo ========================================
echo.

REM Check if Python is installed
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python from: https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo Starting AVIOS UI test server...
echo.
echo Server Port: 8080
echo.
echo ========================================
echo.
echo   Open in your browser:
echo   http://localhost:8080/desktop.html
echo.
echo ========================================
echo.
echo Press Ctrl+C to stop the server
echo.

cd ui
python -m http.server 8080
