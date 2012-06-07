Introduction
------------
Phresco is a framework embedded with all platforms and technologies. In our iPhone pilot project(i.e., Native project) we are developing a shopping cart application using NodeJS web services. Our application is an kind of e-shop where we can able to choose a product , add them to cart and purchase the same. Moreover you can review and submit your comments regarding the product you have purchased or you have viewed. Only registered users are allowed to submit the comments. In our application there are two targets, they are:
1. Phresco - to run the application.
2. HomeViewTest - to run unit test of the application.

Steps to run and deploy the application:
---------------------------------------

In Mac,

   1. Open the application using Xcode Tool.
   2. Add SBJSon libraries to your project to read values from Node JS web services.
   3. Now click on build and run in Xcode.
   4. Your application will get installed in iPhone simulator.

To run Unit test follow the below test:
   
   1. Open the application using Xcode Tool.
   2. Click on Product -> Test
   3. Click on View -> Navigators -> Show log Navigator
   4. It will show how many test cases are executed and how many are passed/failed.