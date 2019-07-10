
hive external tables
===

# create from hdfs file

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS world_cups(
    Year CHAR(4),
    Country CHAR(20),
    Winner CHAR(20),
    RunnersUp CHAR(20),
    Third CHAR(20),
    Fourth CHAR(20),
    GoalsScored INT,
    QualifiedTeams CHAR(20),
    MatchesPlayed CHAR(20),
    Attendance INT
  )
COMMENT 'Data about WorldCups'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
location '/data/hive/cups';


-- insert in data
INSERT INTO table_name (Year, Country, Winner,
VALUES ('3000', 'Brasil', 'Brasil',);
```

# Traefik log
```sql

CREATE EXTERNAL TABLE IF NOT EXISTS views(
  RequestHost CHAR(100),
  RequestPath CHAR(100),
  request_Referer CHAR(255)
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE
location '/data/traefik';
```

-- example of row
```json
{  
   "BackendAddr":"172.18.0.3:9292",
   "BackendName":"backend-formula-compose",
   "BackendURL":{  },
   "ClientAddr":"189.92.201.15:58845",
   "ClientHost":"189.92.201.15",
   "ClientPort":"58845",
   "ClientUsername":"-",
   "DownstreamContentSize":489,
   "DownstreamStatus":200,
   "DownstreamStatusLine":"200 OK",
   "Duration":20555020,
   "FrontendName":"Host-latex-exerciciosresolvidos-net-1",
   "OriginContentSize":489,
   "OriginDuration":20459000,
   "OriginStatus":200,
   "OriginStatusLine":"200 OK",
   "Overhead":96020,
   "RequestAddr":"latex.exerciciosresolvidos.net",
   "RequestContentSize":0,
   "RequestCount":7,
   "RequestHost":"latex.exerciciosresolvidos.net",
   "RequestLine":"GET /formula/f/size/5 HTTP/2.0",
   "RequestMethod":"GET",
   "RequestPath":"/formula/f/size/5",
   "RequestPort":"-",
   "RequestProtocol":"HTTP/2.0",
   "RetryAttempts":0,
   "StartLocal":"2019-06-12T02:08:36.395635846Z",
   "StartUTC":"2019-06-12T02:08:36.395635846Z",
   "downstream_Content-Length":"489",
   "downstream_Content-Type":"image/png",
   "downstream_Date":"Wed, 12 Jun 2019 02:08:36 GMT",
   "downstream_Server":"WEBrick/1.4.2 (Ruby/2.5.3/2018-10-18)",
   "level":"info",
   "msg":"",
   "origin_Content-Length":"489",
   "origin_Content-Type":"image/png",
   "origin_Date":"Wed, 12 Jun 2019 02:08:36 GMT",
   "origin_Server":"WEBrick/1.4.2 (Ruby/2.5.3/2018-10-18)",
   "request_Accept":"image/webp,image/*,*/*;q=0.8",
   "request_Accept-Encoding":"gzip, deflate, sdch, br",
   "request_Accept-Language":"pt-BR,pt;q=0.8,en-US;q=0.6,en;q=0.4",
   "request_Cookie":"_ga=GA1.2.51928152.1560110810; _gid=GA1.2.1906488791.1560303898; _gat=1",
   "request_Referer":"https://www.exerciciosresolvidos.net/razao-e-proporcao/matematica/exercicio-resolvido/razao-e-proporcao-108",
   "request_User-Agent":"Mozilla/5.0 (Linux; Android 5.1.1; SAMSUNG SM-G531H Build/LMY48B) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/6.4 Chrome/56.0.2924.87 Mobile Safari/537.36",
   "time":"2019-06-12T02:08:36Z"
}
```
