ExternalFileUtilIos
-------------------

PhoneGap iOS ExternalFileUtilIos Plugin  
By: Neeraj Sharma, Technology Blueprint Ltd.    

The Cordova ExternalFileUtilIos Plugin is a native Plugin for PhoneGap/Apache Cordova which provides the ability to open documents in an external program on the iOS device. A sample use case would be that you want to provide the user the ability to open a file in another program, of their choosing. For instance, the user wants to open a PDF file in Adobe Reader.

Note: the user must already have the appropriate external reader app installed.

The plugin accepts a URL path to the document which you want to open, as well as the UTI (uniform type identifier). The plugin will then display an "open with" dialog which allows the user to select which file to use for opening the document.

Sample usage for a PDF document:

```var ExternalFileUtil = cordova.require('com.techblue.cordova.plugin.externalfileutilios.ExternalFileUtilIos');```   ```ExternalFileUtil.openWith("http://www.cs.wcupa.edu/docs/jQuery-Cheatsheet.pdf","com.adobe.pdf",success,fail);```   


The PhoneGap native plugin is written in Objective C, with a JavaScript interface to integrate with the client application. It supports Cordova version 2.5 or higher. The plugin workflow is as follows:  

1) App requests openWith action, specifying a file URL and UTI.  
2) Plugin downloads the file and saves as a local temp file.  
3) Plugin uses UIDocumentInteractionController to launch an "open with" dialog.  
4) User selects appropriate app to "preview" the content.  
5) The appropriate reader app is opened and UI/input is changed to that app.  
6) Plugin deletes the temp file.  

