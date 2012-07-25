#import "BaseScreen.js"


function MyCart_Test()
{
try
{
    var com= "MyCart_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
   
    main.buttons()[BrowseButton].tap();
            
    app.delay(2);
    main.tableViews()[0].cells()[0].tap();
    app.delay(2);
    
    main.tableViews()[0].cells()[0].tap();
    app.delay(2);
    main.scrollViews()[0].buttons()[addToCartButton].tap(); 
   
    
    ////Assertion // 
    
   //UIATarget.localTarget().logElementTree();
    
   var val= main.tableViews()[0].cells()[0].textFields()[txtVewQnt].value();

   UIALogger.logMessage("val"+val);
   

   var cost = main.scrollViews()[0].staticTexts()[2].value();
     
   UIALogger.logMessage("cost "+cost);


    main.buttons()[updateCart].tap(); 
   app.delay(2);
    
    
  cost = cost.replace('$','');
  
  UIALogger.logMessage("cost"+cost);
  
  var subVal = parseFloat(cost) * parseFloat(val); 
   UIALogger.logMessage("subVal"+ subVal);
   
   var tot = main.staticTexts()[total].value();
   UIALogger.logMessage("tot "+tot);
   
  // assertEquals("629",subVal);
  //Assert.AreEqual("629","subVal",success);
 
    if(subVal != "629")
    {
        UIALogger.logFail("UnSuccssful");
    }
    else
    {
         UIALogger.logPass("Succssful");
       
    }
    
    /// ===============//
    
    app.delay(2);
    
    
   main.buttons()[viewMyCart].tap();
    app.delay(2);
  
    main.buttons()[checkoutButton].tap();
    app.delay(2);
    
    main.tableViews()[0].cells()[custInfo].tap();
    app.delay(2);
    main.tableViews()[0].cells()[custInfo].tap(); 
    main.tableViews()[0].cells()[delInfo].tap();
    main.tableViews()[0].cells()[2].textFields()[0].setValue(add);
    main.tableViews()[0].cells()[2].textFields()[1].setValue(first);
    main.tableViews()[0].cells()[2].textFields()[2].setValue(last);
    main.tableViews()[0].cells()[2].textFields()[3].setValue(company);
    main.tableViews()[0].cells()[2].textFields()[4].setValue(add1);
    main.tableViews()[0].cells()[2].textFields()[5].setValue(add2);
    main.tableViews()[0].cells()[2].textFields()[6].setValue(city);
    main.tableViews()[0].cells()[2].textFields()[7].setValue(state);
    main.tableViews()[0].cells()[2].textFields()[8].setValue(country);
    main.tableViews()[0].cells()[2].textFields()[9].setValue(code);
    main.tableViews()[0].cells()[2].textFields()[10].setValue(phoneno);
    
    main.tableViews()[0].cells()[billInfo].tap();
    
    main.tableViews()[0].cells()[4].buttons()[checkButton].tap();
    
    main.tableViews()[0].cells()[paytMethods].tap(); 
    main.tableViews()[0].cells()[6].buttons()[cashButton].tap(); 
    main.tableViews()[0].cells()[oderComm].tap();
    
    UIATarget.localTarget().logElementTree();
    
    var text = main.tableViews()[0].cells()[8].textViews()[oderTextView].value();
    UIALogger.logMessage("text "+text);
   
    main.tableViews()[0].cells()[8].textViews()[oderTextView].setValue("Phresco");
     app.delay(2);
    main.buttons()[revieworder].tap(); 
    app.delay(2); 
    main.buttons()[submitButton].tap();
    app.delay(2);
    
    UIALogger.logPass(com);
    
}      
catch(err)
{
            UIALogger.logMessage("There is an error") ;
            if(UIALogger.logError())
            {
                UIATarget.localTarget().captureScreenWithName("MyCart screenshots"); 
            }
}
  
}
MyCart_Test();

