@echo off

if "%1"=="" (
    echo Usage: update-service.bat <service-name>
    exit /b 1
)

set SERVICE_NAME=%1

echo Updating service %SERVICE_NAME% ...

docker-compose up -d --no-deps --build %SERVICE_NAME%

echo Service %SERVICE_NAME% updated successfully.
