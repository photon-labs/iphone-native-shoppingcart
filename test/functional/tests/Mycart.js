#import "BaseScreen.js"
function Comp_Test()
{
    try
    {
    var com= "Comp_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
    var button=main.buttons()[Browser].tap();
    app.delay(2);
    main.tableViews()[category].cells()[computer].tap();
    app.delay(2);
    main.tableViews()[category].cells()[mobile].buttons()[review].tap();
    app.delay(2);
    main.buttons()[back].tap();
    app.delay(2);
    main.tableViews()[category].cells()[mobile].tap();
    app.delay(2);
    main.scrollViews()[detaildesc_tv].buttons()[addcart].tap();
    app.delay(2);
    main.buttons()[1].tap();
    main.tableViews()[category].cells()[mobile].tap();
    app.delay(2);
    main.tableViews()[category].cells()[mobile].tap();
    app.delay(2);
    main.scrollViews()[detaildesc_tv].buttons()[addcart].tap();
    app.delay(2);
    main.buttons()[1].tap();
    app.delay(2);
    main.tableViews()[category].cells()[tablet].tap();
    app.delay(2);
    main.tableViews()[category].cells()[mobile].tap();
    app.delay(2);
    main.scrollViews()[detaildesc_tv].buttons()[addtocart].tap(); 
    main.buttons()[update].tap(); 
    app.delay(2);
    main.buttons()[viewmycart].tap();
    app.delay(2);
    UIALogger.logPass(com);
}
    catch(err)
    {
        UIALogger.logMessage("There is an error") ;
        if(UIALogger.logError())
        {
            UIATarget.localTarget().captureScreenWithName("Mycart_test screenshots"); 
        }
    }
}
Comp_Test();