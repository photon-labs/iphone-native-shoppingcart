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


function Login_Test()
{
try
{
    var log= "Login_Test";
    var app=UIATarget.localTarget();
    var target=app.frontMostApp();
    var main=target.mainWindow();
    main.buttons()[login].tap();
    var textfields = main.textFields(); 
    var passwordfields = main.secureTextFields(); 
    var buttons = main.buttons(); 
    textfields[0].setValue(Email_id); 
    app.delay(2);
    passwordfields[0].setValue(password); 
    app.delay(2);
    target.keyboard().buttons()[RETURN].tap();
    app.delay(2);
    buttons[login1].tap(); 
    app.delay(2);
    main.buttons()[1].tap();
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

