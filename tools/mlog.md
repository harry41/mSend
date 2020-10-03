# mLog Version
 **Version**        : {RELEASE_VER} <br>
 **Release Date**   : {RELEASE_DATE} <br>

#### What is mlog ?
mlog is small script to manage your application logs like nginx, apache, tomcat, laravel, or any other application. it will help you to take backup of your logs file on periodically and will upload in target s3 bucket. it is fully safe and automated. you can use this tool with fully trust and without any data loss.

#### Dependancy
 - aws cli  - you need to install and configure aws cli to upload logs in s3 bucket.

#### Notes:
 - it is recommended to run this script as root. it required root privilage to compress logs and write in log directory `/var/log/mlog`.

##### Step 1: Install Script.
```bash
sudo curl -sL "https://github.com/harry41/mSend/raw/master/tools/mlog" -o /usr/bin/mlog
sudo chmod +x /usr/bin/mlog

# Verify installation
mlog --version
```

#### Getting Start with help


```bash
## mlog -h

mlog [OPTION] src s3
-X, --delete           Delete older than 10 days (e.g. -X 30-40)
-v, --verbose          Enable verbose output (include multiple times for more
                       verbosity, e.g. -vvv)
-u, --s3upload         disable to upload backup on s3 (default: true)
-h, --help             display this help
-V, --version          display version
```

#### example

```bash
#mlog [OPTIONS] "source/file/pattern*.gz" "/other/source/logs/application-*.log" "s3://target-bucket/folder"

mlog /var/log/nginx/access.log-$(date --date='1 days ago' +'%Y-%m-%d').gz  s3://mylog-bucket/logs
```


#### example 2
if we want to push last 10 days logs in s3 bucket. We can use **mlog** within for loop.

* `export LOGDAY=$i` Don't forget to use this variable.

```bash
#mlog [OPTIONS] "source/file/pattern*.gz" "/other/source/logs/application-*.log" "s3://target-bucket/folder"

for (( i = 1; i < 10; i++ )); do
  export LOGDAY=$i
  mlog /var/log/tomcat-app*/app*.log.$(date --date="$i days ago" +'%Y-%m-%d')*  s3://mylog-bucket/logs
done
```
