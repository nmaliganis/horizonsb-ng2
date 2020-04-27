Back End (BE) Install for HorizonSb ----->
1.   A tar file BE_Ver1.0_UAT.tar contains the package for BE application that will be running on http://10.202.234.188:5200/ port of the UAT server
2.   A change must be place into extracted files (appsettings.json) ---> From   "RemoteUrl": "http://dsqa.montana.com", to "RemoteUrl": "{new UAT server will be provide}"
3.   Extracted path /opt/horizon/lib/horizonsb/backend
4.   nohup dotnet horizonsb.api.dll &  to start the Application 
5.   Check that everything running -- test URL:  http://10.202.234.188:5200/swagger/index.html

Front End (FE) Install for HorizonSb ----->
1.   A tar file FE_Ver1.0_UAT.tar contains the package for FE application that will be running on http://10.202.234.188:5100/ port of the UAT server
2.   Extracted path /opt/horizon/lib/horizonsb/frontend
3.   nohup ./frontend/node_modules/serve/bin/serve.js -s frontend/ -l 5100 &  to start the Application 
4.   Check that everything running -- test URL:  http://10.202.234.188:5100

According to an email that was sent from the IT people who created the VM, the right
(and ONLY) way to run things on this VM is to log in as 'user1' with password 'User1234'
and then switch user to 'root' immediately afterwards:

$ ssh user1@10.202.234.188
$ sudo -s

chmod -R 777 ./backend/

