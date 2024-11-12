#!/bin/bash

# do not change these lines: conda configuration
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/prod-crawl-server-user/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/prod-crawl-server-user/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/prod-crawl-server-user/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/prod-crawl-server-user/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

fuser -k 5000/tcp

sleep 2

killall firefox

sleep 2

killall geckodriver

sleep 2


#now=$(date +%d_%b) && user=$(whoami) && /home/$user/anaconda3/envs/reglake/bin/flask run   > /home/$user/ChildUrlXpath_yes/CrawlingEngine/logs/$now.out &



# Get current date and user (this was the issue)
now=$(date '+%d_%b_%Y_%H-%M-%S')  # More precise timestamp to avoid overwriting logs
user=$(whoami)

# Start Flask application (use exec to replace the script process with Flask in the foreground)
exec /home/prod-crawl-server-user/anaconda3/envs/reglake/bin/flask run --host=0.0.0.0 --port=5000 > /home/prod-crawl-server-user/ChildUrlXpath_yes/CrawlingEngine/logs/$now.out 2>&1
