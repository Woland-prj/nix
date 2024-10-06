#!/usr/bin/env bash
# ----------------------------------------------------- 
# Quit all running waybar instances
# ----------------------------------------------------- 
pkill waybar
sleep 0.2
# ----------------------------------------------------- 
# Loading the configuration
# ----------------------------------------------------- 
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
