#import "BaseScreen.js"


function Login_Test()
{
try
{
    var log= "Login_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
   
    
    main.buttons()[LoginButton].tap();
    var textfields = main.textFields(); 
    var passwordfields = main.secureTextFields(); 
    var buttons = main.buttons(); 
    textfields[0].setValue(Email_id); 
    app.delay(2);
    passwordfields[0].setValue(password); 
    app.delay(2);
    target.keyboard().buttons()[RETURN].tap();
    app.delay(2);
    buttons[login_].tap(); 
    app.delay(2);
    UIATarget.localTarget().logElementTree();
    
    //var textValue = main.staticTexts()[logResult].value();
   // UIALogger.logMessage("There is an error"+textValue) ;
    
    var textValue = main.staticTexts()[logResult].value();

    
    if (textValue === logSuccess){ 
        UIALogger.logPass( logSuccess ); 
    }
    else{
        UIALogger.logFail( failed ); 
    }
    
    main.buttons()[okButton].tap();
    app.delay(5);
    
    UIALogger.logPass(log);
    
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
Login_Test();

