@echo off

setlocal enableDelayedExpansion

set environmentFile=conductor.environment
set propsFile=conductor.props

set testFile=example_test_plan.txt
set testName=!testFile!
set outputDir=!testName!_results

@REM Break out date and time values for creating file names
for /f "tokens=1,2,3,4 delims=/ " %%a in ("%date%") do (set wday=%%a&set month=%%b&set day=%%c&set year=%%d)
for /f "tokens=1,2,3,4 delims=:. " %%a in ("%time%") do (set hour=%%a&set minute=%%b&set second=%%c&set millisecond=%%d)

mkdir !outputDir! 2> nul
set outputFile=!outputDir!/!year!!month!!day!_!hour!.!minute!.!second!.txt

echo Results for test plan: !testName! > !outputFile!
echo. >> !outputFile!

@REM Prompt tester for environment specs for test
for /f %%g in (!environmentFile!) do (set /p userInput=What is your %%g? && echo %%g: !userInput! >> !outputFile!)

echo. >> !outputFile!
echo. >> !outputFile!

@REM For each line in the test
for /f "delims=" %%g in (!testFile!) do (

    set currLine=%%g
    if "!currLine:~-1!"=="?" (
        set /p response=%%g 
        echo !time!: %%g : !response! !time! >> !outputFile!
    ) else (
        echo %%g
        echo !time!: %%g >> !outputFile!
        timeout /t -1 > nul
    )

echo. >> !outputFile!

)