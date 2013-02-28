#import "../../../../../main/com/photon/phresco/util/MainActivity.js"
#import "../../../../../main/com/photon/phresco/util/UIElements.js"




function Login_Test(methodName)
{
	try
		{
			clickOnButton(LoginButton);
			target.frontMostApp().mainWindow().textFields()[0].setValue( Email_id);
			//textFields(0, Email_id);
			//passwordTextFields(0, password);
			target.frontMostApp().mainWindow().secureTextFields()[0].setValue(password);
			waitForFewSeconds(2);
			target.frontMostApp().keyboard().typeString("\n");
			clickOnButton(login_);
			waitForFewSeconds(2);
			UIATarget.localTarget().logElementTree();    
    		var textValue = mainwindow.staticTexts()[logResult].value();

    
    		if (textValue === logSuccess){ 
       			 UIALogger.logPass( methodName ); 
    			}
   			 else{
       			 UIALogger.logFail( "Fail" ); 
   			 }
   	 			clickOnButton(okButton);
				waitForFewSeconds(2);    
			
}      
	catch(err)
			{
            UIALogger.logMessage("There is an error") ;
            if(UIALogger.logError())
            {
                UIATarget.localTarget().captureScreenWithName("Login screenshots"); 
            }
}
  
}
Login_Test("Login_Test");





