#  INTRODUCTION ABOUT ROBOT FRAMEWORK
    Robot Framework is a generic open source automation framework. It can be used for test automation and robotic process automation (RPA).
    
    Robot Framework is open and extensible and can be integrated with virtually any other tool to create powerful and flexible automation solutions. Being open source also means that Robot Framework is free to use without licensing costs.
    
    Robot Framework has easy syntax, utilizing human-readable keywords. Its capabilities can be extended by libraries implemented with Python or Java. The framework has a rich ecosystem around it, consisting of libraries and tools that are developed as separate projects.
    
    Robot Framework is operating system and application independent. The core framework is implemented using Python and also runs on Jython (JVM) and IronPython (.NET).

    Robot Framework itself is open source software released under Apache License 2.0, and most of the libraries and tools in the ecosystem are also open source.

# GETTING STARTED
1. # Installation
    1. Install Python (https://www.python.org/downloads/)
    2. Install Pip if it is not installed along with Python
    3. Install Git (https://git-scm.com/downloads)
    4. Install Visual Studio Code (https://code.visualstudio.com/download) (or any supporting tools for Robot Framework)

    Make sure commands work:

        $ python --version
        Python 3.9.2

        $ pip --version
        pip 21.0.1

        $ git --version
        git version 2.31.1.windows.1

        If they do not work, check that they are correctly set in 'PATH'.
    
2. Clone Repository https://github.com/Rajanandh/Miro_Test.git to the location where the git installed.
        $ git clone https://github.com/Rajanandh/Miro_Test.git

3. Install Robot Framework and other dependencies:

        $ pip install -r requirements.txt  (this command install Robot framework and other dependencies such as selenium, selenium library, selenium webdriver for Robot framework)
        Below commands can also be used if no requirements.txt available.  
            $ pip install robotframework
            $ pip install robotframework-seleniumscreenshots
            $ pip install robotframework-seleniumlibrary
            $ pip install selenium
            $ pip install webdrivermanager
            $ pip freeze > requirements.txt  -- to create requirements file
        
        Copy chromedriver to Main folder (Miro_Test) from https://github.com/Rajanandh/Miro_Test/blob/main/chromedriver.exe if web driver not installed correctly
        Copy geckodriver to Main folder (Miro_Test) for Firefox from https://github.com/Rajanandh/Miro_Test/blob/main/geckodriver.exe
 
# BUILD AND TEST
1. Test scripts
    Test scripts are available in the repository https://github.com/Rajanandh/Miro_Test/tree/main/tests/TestScript/
        Folder: tests/TestScript
        Test Script Name: Miro_Signup_test.robot
    
2. Execution   
    Use below command to run the test in Windows Powershell or supporting tool (VisualStudio Code or any)
    $ robot tests/TestScript/Miro_Signup_test.robot  #The Log, Report and Output files will be stored in the main folder (Miro_Test)

    Below command place the output files in separate folder with in main folder.
    $ robot --outputdir tests/TestResults tests/TestScript/Miro_Signup_test.robot

3. Reports/Logs/Output
    Robot Framework generates 3 output files
        1. Log.html
        2. Report.html
        3. Output.xml

    1. # Log
        The log file contains the details about the Test statistics and Test Execution Log for each test case and test steps.
        # To Read the file
            1. Copy the link once the test is completed
            2. Open the link any browser
            3. Easy and readable format
            4. Don't open directly in the repository. If you open directly in the repository, it shows the log with html tab. Instead of that, Pull the file to local and open the file there.

    2. # Report
        This is a html report contains the details about the test summary. It has a link to log
        # To Read the file
            1. Copy the link once the test is completed
            2. Open the link any browser
            3. Easy and readable format
            4. Don't open directly in the repository. If you open directly in the repository, it shows the log with html tab. Instead of that, Pull the file to local and open the file there.

    3. # Output
        The output results are in xml format.

