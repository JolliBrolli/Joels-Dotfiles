#!/usr/bin/env zsh

# Screen recording script for Hyprland using wf-recorder
# Usage: record-screen.zsh [mode] [options]

RECORDINGS_DIR="${HOME}/Videos/Recordings"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
PIDFILE="/tmp/wf-recorder.pid"

# Create recordings directory if it doesn't exist
mkdir -p "$RECORDINGS_DIR"

# Function to check if recording is active
is_recording() {
    [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null
}

# Function to stop recording
stop_recording() {
    if is_recording; then
        local pid=$(cat "$PIDFILE")
        kill -INT "$pid" 2>/dev/null
        rm -f "$PIDFILE"
        notify-send "Recording Stopped" "Screen recording has been saved" -i video-x-generic
        return 0
    else
        notify-send "No Recording" "No active recording found" -i dialog-warning
        return 1
    fi
}

# Function to start recording
start_recording() {
    if is_recording; then
        notify-send "Already Recording" "A recording is already in progress" -i dialog-warning
        return 1
    fi

    local mode="$1"
    local filename="$RECORDINGS_DIR/recording_${TIMESTAMP}.mp4"
    local cmd_args=()
    
    case "$mode" in
        "fullscreen"|"full")
            cmd_args=(-f "$filename")
            notify-send "Recording Started" "Recording full screen" -i video-x-generic
            ;;
        "area"|"region")
            local geometry
            geometry=$(slurp 2>/dev/null)
            if [[ -z "$geometry" ]]; then
                notify-send "Recording Cancelled" "No area selected" -i dialog-information
                return 1
            fi
            cmd_args=(-g "$geometry" -f "$filename")
            notify-send "Recording Started" "Recording selected area" -i video-x-generic
            ;;
        "audio"|"with-audio")
            cmd_args=(-a -f "$filename")
            notify-send "Recording Started" "Recording full screen with audio" -i video-x-generic
            ;;
        "area-audio")
            local geometry
            geometry=$(slurp 2>/dev/null)
            if [[ -z "$geometry" ]]; then
                notify-send "Recording Cancelled" "No area selected" -i dialog-information
                return 1
            fi
            cmd_args=(-a -g "$geometry" -f "$filename")
            notify-send "Recording Started" "Recording selected area with audio" -i video-x-generic
            ;;
        *)
            echo "Usage: $0 {fullscreen|area|audio|area-audio|stop|toggle}"
            echo "  fullscreen - Record entire screen"
            echo "  area       - Record selected area"
            echo "  audio      - Record screen with audio"
            echo "  area-audio - Record selected area with audio"
            echo "  stop       - Stop current recording"
            echo "  toggle     - Toggle recording (stop if running, start fullscreen if not)"
            return 1
            ;;
    esac

    # Start recording in background
    wf-recorder "${cmd_args[@]}" &
    local pid=$!
    echo "$pid" > "$PIDFILE"
    
    # Wait a moment to check if it started successfully
    sleep 0.5
    if ! kill -0 "$pid" 2>/dev/null; then
        rm -f "$PIDFILE"
        notify-send "Recording Failed" "Failed to start recording" -i dialog-error
        return 1
    fi
}

# Function to toggle recording
toggle_recording() {
    if is_recording; then
        stop_recording
    else
        start_recording "fullscreen"
    fi
}

# Main script logic
case "$1" in
    "stop")
        stop_recording
        ;;
    "toggle")
        toggle_recording
        ;;
    "status")
        if is_recording; then
            echo "Recording is active (PID: $(cat "$PIDFILE"))"
        else
            echo "No active recording"
        fi
        ;;
    *)
        start_recording "$1"
        ;;
esac
