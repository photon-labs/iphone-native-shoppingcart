#import "../../../../../main/com/photon/phresco/util/MainActivity.js"
#import "../../../../../main/com/photon/phresco/util/UIElements.js"




function Login_Test(methodName)
{
	try
		{
			clickOnButton(LoginButton);
			textFields(0, Email_id);
			passwordTextFields(0, password);	
			waitForFewSeconds(2);
			application.keyboard().buttons()[RETURN].tap();
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



