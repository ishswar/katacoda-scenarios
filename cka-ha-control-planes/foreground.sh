while [ ! -f /usr/local/bin/wait.sh ]
do
  sleep 2
done
sleep 2; wait.sh ; . ~/.bashrc;