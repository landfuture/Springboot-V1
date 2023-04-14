:: Commit Id is Logged
echo Current Commit ID:
git log -n1 --format="%%h"

:: Creating the temporary folder to store the version details
mkdir "C:\Users\cjs99\Jenkins\tmp"

:: Saving the commit Id to Version.txt
git log -n1 --format="%%h" > "C:\Users\cjs99\Jenkins\tmp\version.txt"

@FOR /F %%i in ('type C:\Users\cjs99\Jenkins\tmp\version.txt') DO set version=%%i

echo %version%

:: Creating the build folder - used for easier reference
mkdir "C:\Users\cjs99\Jenkins\Builds\SpringbootV1"

:: Copying the build output - war file to the build folder
copy /Y "%WORKSPACE%\target\SpringbootV1-0.0.1-SNAPSHOT.war" "C:\Users\cjs99\Jenkins\Builds\SpringbootV1"
copy /Y "%WORKSPACE%\deployments\Dockerfile" "C:\Users\cjs99\Jenkins\Builds\SpringbootV1"

cd "C:\Users\cjs99\Jenkins\Builds\SpringbootV1"

docker build -t cjs992911/springboot-v1:%version% -t cjs992911/springboot-v1:latest .
docker push cjs992911/springboot-v1:%version%
docker push cjs992911/springboot-v1:latest
