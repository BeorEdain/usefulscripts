#!/bin/bash -e

ps aux | egrep "Z|defunct"
read -p "Point me at the zombie: " pid_to_kill
pid_parent=$(ps -o ppid= -p $pid_to_kill)
echo Parent PID: $pid_parent
sudo kill -SIGKILL $pid_parent