#!/usr/bin/env bash

NOT_LOGGED_IN_ICON=""
DISCONNECTED_ICON="󰦞"
CONNECTED_ICON="󰦝"
FAILURE_ICON="󰻌"


get_loggedin_status() {
    mullvad account get | grep "Not logged in" &> /dev/null
}

get_connected_status() {
    mullvad status | grep "Disconnected" &> /dev/null
}

get_loggedin_status
if [ $? -eq 0 ]; then

    printf '{"text":"%s","tooltip":"%s","class":"%s","percentage":%d}\n' "$NOT_LOGGED_IN_ICON Not logged in" "You are not logged in" "error" "0"
    exit 1
fi


if [ $1 == "status" ]; then
    get_connected_status
    VPN_CONNECTED=$?
    if [ $VPN_CONNECTED -eq 1 ]; then
        text="$CONNECTED_ICON Connected"
        tooltip="You are connected" # Add connection information here!
        class="connected"
    else
        text="$DISCONNECTED_ICON Disconnected"
        tooltip="You are disconnected"
        class="disconnected"
    fi


elif [ $1 == "connect" ]; then
    mullvad connect --wait &>/dev/null
    if [ $? -ne 0 ]; then
        text="$FAILURE_ICON Failure"
        tooltip="Failed to connect"
        class="error"
    else
        text="$CONNECTED_ICON Connected"
        tooltip="You are connected" # Add connection information here!
        class="connected"
    fi

elif [ $1 == "disconnect" ]; then
    mullvad disconnect --wait &>/dev/null
    if [ $? -ne 0 ]; then
        text="$FAILURE_ICON Failure"
        tooltip="Failed to disconnect"
        class="error"
    else
        text="$DISCONNECTED_ICON Disconnected"
        tooltip="You are disconnected"
        class="disconnected"
    fi


elif [ $1 == "toggle" ]; then
    get_connected_status
    VPN_CONNECTED=$?
    if [ $VPN_CONNECTED -eq 1 ]; then
        mullvad disconnect --wait &>/dev/null
    else
        mullvad connect --wait &>/dev/null
    fi

    if [ $VPN_CONNECTED -eq 1 ] && [ $? -ne 0 ]; then
        text="$FAILURE_ICON Failure"
        tooltip="Failed to disconnect"
        class="error"
    elif [ $VPN_CONNECTED -eq 0 ] && [ $? -ne 0 ]; then
        text="$FAILURE_ICON Failure"
        tooltip="Failed to connect"
        class="error"
    else
        sleep 2
        get_connected_status
        VPN_CONNECTED=$?
        if [ $VPN_CONNECTED -eq 1 ]; then
            text="${CONNECTED_ICON} Connected"
            tooltip="You are connected" # Add connection information here!
            class="connected"
        else
            text="$DISCONNECTED_ICON Disconnected"
            tooltip="You are disconnected"
            class="disconnected"
        fi
    fi

else
    text="$FAILURE_ICON Failure"
    tooltip="Invalid argument"
    class="error"
fi

percentage="0"
printf '{"text":"%s","tooltip":"%s","class":"%s","percentage":%d}\n' "$text" "$tooltip" "$class" "$percentage"
