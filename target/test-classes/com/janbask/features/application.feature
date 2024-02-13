Feature: object feature

    Background: 
        * url apiUrl   
        * def originURL = 'https://core-api.janbaskplatform-development.com' 
        * callonce read('login.feature')
        * call read('object.feature@createObject')
        * def lastFourDigits = java.lang.System.nanoTime().toString().substring(10)
        * def RandomName = "application" + lastFourDigits
        
           
     @getAllApplication 
     Scenario: Get All Application
        Given path '/api/apps'
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 200
        * print response
        And def expectedMessage = 'Apps List Fetched.'
        And match expectedMessage == response.message

	  @positive @createAppliation
    Scenario: Create application scenario
        Given path '/api/apps'
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        And def json = read('classpath:com/janbask/payloads/createApplication.json')
        And set json.objects[0].object_id = objectId
        And request json
        When method post
        Then status 200
        * print response
        And def expectedMessage = 'App Inserted'
        And match expectedMessage == response.message
        And def appId = response.data._id
        
     @getAppDetails
     Scenario: Get application Details
        * call read('application.feature@createAppliation')
        Given path '/api/apps/' + appId
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 200
        * print response
        And def expectedMessage = 'Application fetched.'
        And match expectedMessage == response.message
        
        
        @negative @getAppDetails
     Scenario: Get application Details
        Given path '/api/apps/' + 12345
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 400
        * print response
        And def expectedMessage = 'Validation Error.'
        And match expectedMessage == response.message
        
        
         @positive @UpdateObject
    Scenario: Update object scenario
        * call read('application.feature@createAppliation')
        Given path '/api/apps/' + appId
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        And def json = read('classpath:com/janbask/payloads/updateApplication.json')
        And set json.objects[0].object_id = objectId
        And request json
        When method put
        Then status 200
        * print response
        And def expectedMessage = 'Application Updated'
        And match expectedMessage == response.message
        
                
         @negative @UpdateObject
    Scenario: Update object scenario
        * call read('application.feature@createAppliation')
        Given path '/api/apps/' + '1234'
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        And def json = read('classpath:com/janbask/payloads/updateApplication.json')
        And set json.objects[0].object_id = objectId
        And request json
        When method put
        Then status 400
        * print response
        And def expectedMessage = 'Invalid Error.'
        And match expectedMessage == response.message
        
        
        
        
        
        
        
        
        
        