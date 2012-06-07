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
    main.tableViews()[quantity].cells()[tv].tap();
    target.keyboard().buttons()[number].tap(); 
    app.delay(2);
    target.keyboard().keys()[one].tap(); 
    app.delay(2);
    target.keyboard().buttons()[done].tap();
    app.delay(2);
    main.buttons()[update].tap(); 
    app.delay(2);
    main.buttons()[viewmycart].tap();
    app.delay(2);
    main.buttons()[checkout].tap();
    app.delay(2);
    main.tableViews()[info].cells()[customer].tap();
    app.delay(2);
    main.tableViews()[info].cells()[customer].tap(); 
    main.tableViews()[info].cells()[delivery].tap();
    main.tableViews()[info].cells()[value].textFields()[0].setValue(add);
    main.tableViews()[info].cells()[value].textFields()[1].setValue(first);
    main.tableViews()[info].cells()[value].textFields()[2].setValue(last);
    main.tableViews()[info].cells()[value].textFields()[3].setValue(company);
    main.tableViews()[info].cells()[value].textFields()[4].setValue(add1);
    main.tableViews()[info].cells()[value].textFields()[5].setValue(add2);
    main.tableViews()[info].cells()[value].textFields()[6].setValue(city);
    main.tableViews()[info].cells()[value].textFields()[7].setValue(state);
    main.tableViews()[info].cells()[value].textFields()[8].setValue(country);
    main.tableViews()[info].cells()[value].textFields()[9].setValue(code);
    main.tableViews()[info].cells()[value].textFields()[10].setValue(phoneno);
    main.tableViews()[info].cells()[billing].tap();
    main.tableViews()[info].cells()[same].buttons()[sameaddress].tap();
    main.tableViews()[info].cells()[payment].tap(); 
    main.tableViews()[info].cells()[mode].buttons()[cash].tap(); 
    UIALogger.logPass(com);
}
    catch(err)
    {
        UIALogger.logMessage("There is an error") ;
        if(UIALogger.logError())
        {
            UIATarget.localTarget().captureScreenWithName("Computer_test screenshots"); 
        }
    }

}
Comp_Test();