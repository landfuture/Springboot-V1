@echo off
@REM kubectl get deployment springboot-v1 | findstr springboot-v1
set deployment=""
set empty=''
set kubeVersion=""

echo Executing Command: kubectl get deployments -o=jsonpath='{$.items[0].spec.template.spec.containers[0].image}'
@FOR /f %%i in ('kubectl get deployment springboot-v1') DO set deployment=%%i
echo Current Deployment %deployment%
echo Version to be deployed: %version%

if %deployment% == "" (
	echo Current Deployment %deployment% 222
) else (
	kubectl get deployments -o=jsonpath='{$.items[0].spec.template.spec.containers[0].image}' > imageversion.csv
	@FOR /F %%i in ('type imageversion.csv') DO set kubeVersion=%%i
)

echo Currently Deployed Version: %kubeVersion%

if %deployment% == "" (
	echo Deployment not found
	echo Executing command: kubectl apply -f %WORKSPACE%\deployments\deployment.yaml
	kubectl apply -f %WORKSPACE%\deployments\deployment.yaml
	
	if %version% == latest (
		echo Deployed the latest version of the build
	) else (
		echo Executing command: kubectl set image deployment springboot-v1 infotrends=jakinkorea/springboot-v1:%version%
		kubectl set image deployment springboot-v1 infotrends=jakinkorea/springboot-v1:%version%
		echo Deployed the %version% version of the build
	)
	echo Successfully deployed the service
	echo ------------------------------------------------------------
	echo Deployments:
	kubectl get deployment springboot-v1
	echo Services Deployed:
	kubectl get service springboot-v1
	echo ------------------------------------------------------------
) else (
	echo Deployment found
	
	if %version% == latest (

		if %kubeVersion%=='jakinkorea/springboot-v1:latest' (
			echo Executing Command: kubectl rollout restart deployment/springboot-v1
			kubectl rollout restart deployment/springboot-v1
		) else (
			echo Currently Older Version Of the Build is Deployed
			echo Executing command: kubectl set image deployment springboot-v1 infotrends=jakinkorea/springboot-v1:%version%
			kubectl set image deployment springboot-v1 infotrends=jakinkorea/springboot-v1:%version%
		)
		
	) else (
		echo Executing command: kubectl set image deployment springboot-v1 infotrends=jakinkorea/springboot-v1:%version%
		kubectl set image deployment springboot-v1 infotrends=jakinkorea/springboot-v1:%version%
	)
	echo Deployed the %version% version of the build
	echo Successfully redeployed the service
	echo ------------------------------------------------------------
	echo Deployments:
	kubectl get deployment springboot-v1
	echo Services Deployed:
	kubectl get service springboot-v1
	echo ------------------------------------------------------------
)

