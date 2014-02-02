COMMAND="0 * * * * $(pwd)/backup.sh"
crontab -l > newtab
echo "$COMMAND" >> newtab
crontab newtab
rm newtab