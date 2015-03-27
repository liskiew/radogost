# radogost

[Radogost](http://en.wikipedia.org/wiki/Radegast_%28god%29) 
is an old god of hospitality in the Slavic mythology.

This project is a set of scripts to:
* fetch backup from remote machines using [scp](http://en.wikipedia.org/wiki/Secure_copy) 

## Download 

``` 
cd $HOME
git clone https://github.com/goodylabs/radogost.git
```

## Install in crontab

```
{ crontab -l ; echo '38 5 * * * $HOME/radogost/scripts/fetch_latest_backups.sh evouchers somehost.com 22 /home/some_remote_user/backup "db_backup_prod-*.sql.gz" $HOME/project_x 3'; } | crontab -
```
