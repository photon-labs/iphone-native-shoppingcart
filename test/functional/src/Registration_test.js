#import "BaseScreen.js"


function Register_Test()
{
try
{
    var log= "Register_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
   
    main.buttons()[RegistrationButton].tap();
    main.scrollViews()[0].textFields()[0].setValue(first);
    app.delay(2);
    main.scrollViews()[0].textFields()[1].setValue(last);
    app.delay(2);
    main.scrollViews()[0].textFields()[2].setValue(Email_id); 
    app.delay(2);
    main.scrollViews()[0].secureTextFields()[0].setValue(password); 
    app.delay(2);
    main.scrollViews()[0].secureTextFields()[1].setValue(password);
    app.delay(2);
    var buttons = main.buttons(); 
    target.keyboard().buttons()[RETURN].tap();
    app.delay(2);
    buttons[register_].tap(); 
    app.delay(2);
        
    var textValue = main.staticTexts()[labelResult].value();

    
    if (textValue === logSuccess){ 
        UIALogger.logPass( logSuccess ); 
    }
    else{
        UIALogger.logFail( failed ); 
    }
        
    main.buttons()[buttonOk].tap();
    app.delay(2);
        
    UIALogger.logPass(log);
    
}      
catch(err)
{
            UIALogger.logMessage("There is an error") ;
            if(UIALogger.logError())
            {
                UIATarget.localTarget().captureScreenWithName("Register screenshots"); 
            }
}
  
}
Register_Test();

