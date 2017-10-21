# Democracy Club Bots

Orchestration script for running DC Slack and GitHub bots

* Spin up a `t2.nano` based on `ami-674cbc1e`
* `git clone https://github.com/DemocracyClub/dc-bots.git`
* `cd dc-bots`
* `./provision` to configure the server
* `cp settings.example.json settings.json`
* Set up any additional settings
* Configure cron to run the bots e.g:

```
MAILTO="someone@example.com"
1 */6 * * * cd /home/ubuntu/dc-bots/ && /home/ubuntu/dc-bots/bots.sh
```
