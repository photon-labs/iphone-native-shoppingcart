/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
#import "BaseScreen.js"
function Mobile_Test()
{
    try
    {
    var mob= "Mobile_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
    var button=main.buttons()[Browser].tap();
    app.delay(2);
    main.tableViews()[category].cells()[mobile].tap();
    app.delay(2);
    main.tableViews()[category].cells()[tv].buttons()[review].tap();
    app.delay(2);
    main.buttons()[back].tap();
    app.delay(2);
    main.tableViews()[category].cells()[tv].tap();
     app.delay(2);
    main.scrollViews()[detaildesc_tv].buttons()[addtocart].tap();
    main.tableViews()[quantity].cells()[tv].tap();
    target.keyboard().buttons()[Delete].tap();
    app.delay(2);
    target.keyboard().buttons()[number].tap(); 
    app.delay(2);
    target.keyboard().keys()[Three].tap(); 
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
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[0].setValue(add);
    main.tableViews()[info].cells()[value].textFields()[1].setValue(first);
    main.tableViews()[info].cells()[value].textFields()[2].setValue(last);
    main.tableViews()[info].cells()[value].textFields()[3].setValue(company);
    main.tableViews()[info].cells()[value].textFields()[4].setValue(add1);
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[5].setValue(add2);
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[6].setValue(city);
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[7].setValue(state);
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[8].setValue(country);
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[9].setValue(code);
    app.delay(2);
    main.tableViews()[info].cells()[value].textFields()[10].setValue(phoneno);
    app.delay(2);
    main.tableViews()[info].cells()[billing].tap();
    main.tableViews()[info].cells()[same].buttons()[sameaddress].tap();
    app.delay(2);
    main.tableViews()[info].cells()[payment].tap(); 
    app.delay(2);
    main.tableViews()[info].cells()[mode].buttons()[cash].tap(); 
    app.delay(2);
    UIALogger.logPass(mob);
}
catch(err)
{
    UIALogger.logMessage("There is an error") ;
    if(UIALogger.logError())
    {
        UIATarget.localTarget().captureScreenWithName("Mobile_test screenshots"); 
    }
}
}
Mobile_Test();