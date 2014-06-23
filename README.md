waad-saml
----

Simple JavaEE web application demonstrating [SAML](http://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) Request Binding SSO with Windows Azure Active Directory ([WAAD](http://azure.microsoft.com/en-us/services/active-directory/)) as the [IDP](http://en.wikipedia.org/wiki/Identity_provider) and [Jetty](http://eclipse.org/jetty/) with [PicketLink](http://picketlink.org/) as the [SP](http://en.wikipedia.org/wiki/Service_provider). 

----
## Windows Azure setup

1. Create an Azure account. 

2. Once the account is registered an Active Directory instance will be available. Click on it.

3. On the top tab click applications. At the very bottom click the add button.

4.  Enter in the application's URL that will be receiving the SAML POST assertion. PicketLink scan's incoming un-authenticated requests for SAML parameters so you may use any URL. For this example the the Jetty web server will be running on the localhost and the assertion will be posted to the base context: https://localhost:8443/waad-saml/

![alt text](https://raw.githubusercontent.com/aaronanderson/waad-saml/master/addApplication.png "Add Application")

5. Select the application and click the Endpoints button at the bottom. Observe the Federation Metadata and SAML-P URLs.

![alt text](https://raw.githubusercontent.com/aaronanderson/waad-saml/master/endpoints.png "Endpoints")

6. Update the src/main/webapp/WEB-INF/picketlink.xml file's IdentityURL with the SAML-P URL. 
       
7. Examine the bottom of the Federation Metadata XML document and copy and paste the contents of the                    ds:X509Certificate element into the src/waad.cer file. You will need to insert new line characters into the Base64 encoded certificate to make it identically match the X509 ASCII format in the sample. 

8. Run the project with maven
    mvn clean install jetty:run

9. Access https://localhost:9443/waad-saml 

10. Click on the link to the projected URL and you should be redirected to WAAD for authentication.

11. Once authenticated you should be redirected back to the protected URL which should display your user principal name (email address) and first name and last name (SAML attributes).




**Note the following restrictions:** 

1. currently the src/main/webapp/idm-metadata.xml and src/main/webapp/idm-metadata.xml files are not being utilized and are included for future reference.

2. Microsoft at the moment supports the SAML HTTP Redirect binding and they are working on support fot the POST binding.

3. This example requires a [few enhancements](https://issues.jboss.org/browse/PLINK-506) to the new Jetty PicketLink binding have been submitted but not accepted at the time of this writing. Be sure to use the latest PicketLink Binding snapshots with the fixes applied. 

4. The PicketLink SAML SP Jetty Forms Authenticator requires Jetty to be configured with a loginService. Typically the HashLoginService is used. The Authenticator will set the principal name and roles ignoring whatever the loginService provides but it must be configured regardless.  

5. Parsing the IDM metadata to setup SAML via the picketlink.xml file is currently not supported (while the certificate is read from the metadata the SPWorkFlow requires a full blown TrustKeyManager to perform the validation)

6. WAAD has it's own entitlements service based on oAuth 2 and as far as I know there is no way to configure WAAD to pass role information in the SAML request. Usually an application will use it's own local role and authorization data anyway. A future enhancement may be to add a SAML Handler to read in role information from a PicketLink IdentityStore or implementing LoginService that also uses the PicketLink IdentityStore. This way WAAD would perform the remote authentication and PicketLink the local authorization.

