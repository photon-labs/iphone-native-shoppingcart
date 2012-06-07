#import "BaseScreen.js"
function Register_Test()
{
    try
    {
    var reg= "Register_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
    var button1=main.buttons()[register].tap();
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
    buttons[register2].tap(); 
    app.delay(2);
    main.buttons()[1].tap();
    app.delay(5);
    UIALogger.logPass(reg);
}    
    catch(err)
    {
        UIALogger.logMessage("There is an error") ;
        if(UIALogger.logError())
        {
            UIATarget.localTarget().captureScreenWithName("Register_test screenshots"); 
        }
    }

}
Register_Test();
