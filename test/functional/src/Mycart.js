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