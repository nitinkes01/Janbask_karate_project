
Feature: object feature

    Background: 
        * url apiUrl   
        * def originURL = 'https://core-api.janbaskplatform-development.com' 
        * callonce read('login.feature')
        * def lastFourDigits = java.lang.System.nanoTime().toString().substring(10)
        * def RandomName = "object" + lastFourDigits
        * def createObjectBody = read('classpath:com/janbask/payloads/createObject.json')
        * def updateObjectBody = read('classpath:com/janbask/payloads/updateObject.json')
        
    @positive @createObject
    Scenario: Create object scenario
        Given path '/api/objects'
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        And request createObjectBody
        When method post
        Then status 200
        * print response
        And def expectedMessage = 'Object Inserted'
        And match expectedMessage == response.message
        And def objectId = response.data._id

       	
        
    @negative  
    Scenario: Create object scenario with same Name
        Given path '/api/objects'
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        And request read('classpath:com/janbask/payloads/createObject_duplicateName.json')
        When method post
        Then status 500
        * print response
        And def expectedMessage = 'Object System Name Already exist, Please use another name.'
        And match expectedMessage == response.message
         
         
               
     @getHierrarchy 
     Scenario: Get Hierrarchy scenario
        * call read('object.feature@createObject')
        Given path '/api/objects/relational-hierarchy/' + objectId
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 200
        * print response
        And def expectedMessage = 'Heirarchy Fetched.'
        And match expectedMessage == response.message
        
        
       
     @getObjectList   
     Scenario: Get Object List
        Given path '/api/objects'
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 200
        * print response
        And def expectedMessage = 'Objects List Fetched.'
        And match expectedMessage == response.message
 
 
 
     @getObjectDetails
     Scenario: Get Object Details
        * call read('object.feature@createObject')
        Given path '/api/objects/' + objectId
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 200
        * print response
        And def expectedMessage = 'Object fetched.'
        And match expectedMessage == response.message
        
        
        
     @negative @getObjectDetails
     Scenario: Get Object Details with wrong object id
        * call read('object.feature@createObject')
        Given path '/api/objects/' + 123456789
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 500
        * print response
        And def expectedMessage = 'Invalid Object_id 123456789'
        And match expectedMessage == response.message




     @getRealtedObject
     Scenario: Get related Object
        * call read('object.feature@createObject')
        Given path '/api/objects/related/' + objectId
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        When method get
        Then status 200
        * print response
        And def expectedMessage = 'Successfuly fetched related Objects.'
        And match expectedMessage == response.message



     @positive @UpdateObject
    Scenario: Update object scenario
        * call read('object.feature@createObject')
        Given path '/api/objects/' + objectId
        And header origin = originURL
        And header Authorization = 'Bearer ' + token 
        And def json = read('classpath:com/janbask/payloads/updateObject.json')
        And set json._id = objectId
        And set json.global_search_view[0].field_id = objectId
        And request json
        When method put
        Then status 200
        * print response
        And def expectedMessage = 'Object Updated'
        And match expectedMessage == response.message
       


















