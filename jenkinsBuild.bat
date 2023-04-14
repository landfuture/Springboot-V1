:: Commit Id is Logged
echo Current Commit ID:
git log -n1 --format="%%h"

:: Saving the commit Id to Version.txt
git log -n1 --format="%%h" > "C:\zzz_in_c\temp\version.txt"

:: Creating the build folder - used for easier reference
mkdir "C:\zzz_in_c\Project_Root_in_C\Springboot-V1"

:: Copying the build output - war file to the build folder
copy /Y "%WORKSPACE%\target\SpringbootV1-0.0.1-SNAPSHOT.war" "C:\zzz_in_c\Project_Root_in_C\Springboot-V1"

:: Copying the war file and the version.txt with commit id to the remote server
:: scp -i "C:\Users\Raja Vignesh\Jenkins\keys\ec2-connect.pem" "C:\zzz_in_c\temp\version.txt" "%WORKSPACE%\target\SpringbootV1-0.0.1-SNAPSHOT.war" ec2-user@ec2-66-0-210-52.ap-south-1.compute.amazonaws.com:/home/ec2-user/Jenkins/tmp_Build

scp -i "C:\zzz_in_c\ETC\identity-100-cjs99.pem" "C:\zzz_in_c\temp\version.txt" "C:\Users\cjs99\AppData\Local\Jenkins\.jenkins\workspace\SpringbootV1\target\SpringbootV1-0.0.1-SNAPSHOT.war" cjs99@192.168.1.100:/home/cjs99/Jenkins/tmp_Build 
