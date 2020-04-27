dotnet publish
dotnet horizonsb.api.dll

htop -d 10

nohup dotnet horizonsb.api.dll &

cd opt/horizon/lib/horizonsb/

PS AUX
kill -SIGTERM 

ssh user1@10.202.234.188
http://10.202.234.188:5200/swagger/index.html

horizon service horizonsb-backend restart
horizon service horizonsb-backend start
horizon service horizonsb-backend stop

chmod -R 777 ./


horizon service horizonsb-frontend restart
horizon service horizonsb-frontend start
horizon service horizonsb-frontend stop

ssh root@10.85.45.25
ssh user1@10.202.233.250

http://10.202.233.250:5100/
http://10.202.233.250:5200/swagger/index.html


curl --location --request GET 'https://sportsbetmontana.com/en/webservice/events/available/sports' \
--header 'Service-token: 94c54e775eb11e98b383372a71702613' \
--header 'Content-Type: application/json'


//QA
{
  "ConnectionString": "Server=10.85.45.25;Database=horizonsb_db;Port=5432;User Id=horizonsb;Password=horizonsb;",
  "RedisConnectionString": "10.85.45.25",
  "LocalUrl": "http://10.85.45.25:5200",
  "RemoteUrl": "http://dsqa.montana.com",
  "WsRemoteUrl": "ws://dsqa.montana.com",
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}

//UAT
{
  "ConnectionString": "Server=10.202.234.188;Database=horizonsb_db;Port=5432;User Id=horizonsb;Password=horizonsb;",
  "RedisConnectionString": "10.202.234.188",
  "LocalUrl": "http://10.202.234.188:5200",
  "RemoteUrl": "http://dsuat.mtsb.u.priv",
  "WsRemoteUrl": "ws://dsuat.mtsb.u.priv",
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}


//prod
{
  "ConnectionString": "Server=10.202.233.250;Database=horizonsb_db;Port=5432;User Id=horizonsb;Password=horizonsb;",
  "RedisConnectionString": "10.202.233.250",
  "LocalUrl": "http://10.202.233.250:5200",
  "RemoteUrl": "https://sportsbetmontana.com",
  "WsRemoteUrl": "wss://sportsbetmontana.com",
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}

//dis
{
  "ConnectionString": "Server=10.202.241.250;Database=horizonsb_db;Port=5432;User Id=horizonsb;Password=horizonsb;",
  "RedisConnectionString": "10.202.241.250",
  "LocalUrl": "http://10.202.241.250:5200",
  "RemoteUrl": "https://sportsbetmontana.com",
  "WsRemoteUrl": "wss://10.202.241.201",
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*"
}



