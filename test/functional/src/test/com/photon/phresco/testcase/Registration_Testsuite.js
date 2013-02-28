#import "../../../../../main/com/photon/phresco/util/MainActivity.js"
#import "../../../../../main/com/photon/phresco/util/UIElements.js"


function Register_Test(methodName)
{
try
{
	
	
	clickOnButton(RegistrationButton);
	
    mainwindow.scrollViews()[0].textFields()[0].setValue(first);
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].textFields()[1].setValue(last);
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].textFields()[2].setValue(Email_id); 
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].secureTextFields()[0].setValue(password); 
    waitForFewSeconds(2);
	mainwindow.scrollViews()[0].secureTextFields()[1].setValue(password);
    waitForFewSeconds(2);
	
    application.keyboard().buttons()[RETURN].tap();
    waitForFewSeconds(2);
    clickOnButton(register_);
    waitForFewSeconds(2);
        
    var textValue = mainwindow.staticTexts()[labelResult].value();

    
    if (textValue === logSuccess){ 
        UIALogger.logMessage("Register Success") ;
    }
    else{
       UIALogger.logMessage("Register Fail") ;
    }
       
	clickOnButton(buttonOk);
	waitForFewSeconds(2);
    UIALogger.logPass( methodName );     
	
    
}      
catch(err)
{
            UIALogger.logMessage("There is an error") ;
            UIALogger.logFail(methodName);
            if(UIALogger.logError())
            {
               captureScreenshot("Register screenshots"); 
            }
}
  
}
Register_Test("Register_Test");

