#import "../../../../../main/com/photon/phresco/util/MainActivity.js"
#import "../../../../../main/com/photon/phresco/util/UIElements.js"


function MyCart_Test(methodName)
{
try
{
	clickOnButton(BrowseButton);        
    waitForFewSeconds(2);
	clickOnTableCell(0);
	waitForFewSeconds(2);
	clickOnTableCell(0);
	waitForFewSeconds(2);
    mainwindow.scrollViews()[0].buttons()[addToCartButton].tap(); 
   
    
	
   var val= mainwindow.tableViews()[0].cells()[0].textFields()[txtVewQnt].value();

   UIALogger.logMessage("val"+val);
   

   var cost = mainwindow.scrollViews()[0].staticTexts()[2].value();
     
   UIALogger.logMessage("cost "+cost);

	clickOnButton(updateCart);  
	waitForFewSeconds(2);
    
    
  cost = cost.replace('$','');
  
  UIALogger.logMessage("cost"+cost);
  
  var subVal = parseFloat(cost) * parseFloat(val); 
   UIALogger.logMessage("subVal"+ subVal);
   
   var tot = mainwindow.staticTexts()[total].value();
   UIALogger.logMessage("tot "+tot);
   
	
 
    if(subVal != "629")
    {
        UIALogger.logFail("UnSuccssful");
    }
    else
    {
         UIALogger.logPass(methodName);
       
    } 
    
	
    
    waitForFewSeconds(2);
    clickOnButton(viewMyCart);        
	
	clickOnButton(checkoutButton);        
    waitForFewSeconds(2);
	
	clickOnTableCell(custInfo);
	waitForFewSeconds(2);
	
	clickOnTableCell(custInfo);
	waitForFewSeconds(2);
	
	clickOnTableCell(delInfo);    
    mainwindow.tableViews()[0].cells()[2].textFields()[0].setValue(add);
    mainwindow.tableViews()[0].cells()[2].textFields()[1].setValue(first);
    mainwindow.tableViews()[0].cells()[2].textFields()[2].setValue(last);
    mainwindow.tableViews()[0].cells()[2].textFields()[3].setValue(company);
    mainwindow.tableViews()[0].cells()[2].textFields()[4].setValue(add1);
    mainwindow.tableViews()[0].cells()[2].textFields()[5].setValue(add2);
    mainwindow.tableViews()[0].cells()[2].textFields()[6].setValue(city);
    mainwindow.tableViews()[0].cells()[2].textFields()[7].setValue(state);
    mainwindow.tableViews()[0].cells()[2].textFields()[8].setValue(country);
    mainwindow.tableViews()[0].cells()[2].textFields()[9].setValue(code);
    mainwindow.tableViews()[0].cells()[2].textFields()[10].setValue(phoneno);
    
    mainwindow.tableViews()[0].cells()[billInfo].tap();
    
    mainwindow.tableViews()[0].cells()[4].buttons()[checkButton].tap();
    
    mainwindow.tableViews()[0].cells()[paytMethods].tap(); 
    mainwindow.tableViews()[0].cells()[6].buttons()[cashButton].tap(); 
    mainwindow.tableViews()[0].cells()[oderComm].tap();
    
    UIATarget.localTarget().logElementTree();
    
    var text = mainwindow.tableViews()[0].cells()[8].textViews()[oderTextView].value();
    UIALogger.logMessage("text "+text);
   
    mainwindow.tableViews()[0].cells()[8].textViews()[oderTextView].setValue("Phresco");
    waitForFewSeconds(2);
    mainwindow.buttons()[revieworder].tap(); 
    waitForFewSeconds(2);
    mainwindow.buttons()[submitButton].tap();
    waitForFewSeconds(5);
    
	 UIALogger.logPass(methodName);
	
    
}      
catch(err)
{
           UIALogger.logFail("Fail");
            UIALogger.logMessage("There is an error") ;
            if(UIALogger.logError())
            {
                UIATarget.localTarget().captureScreenWithName("MyCart screenshots"); 
            }
}
  
}
MyCart_Test("Mycart_Test");

