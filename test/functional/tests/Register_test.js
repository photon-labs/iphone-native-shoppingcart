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
