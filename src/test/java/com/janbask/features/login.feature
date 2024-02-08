Feature: login feature

    Background: 
        * url 'https://core-api.janbaskplatform-development.com'   
        * def originURL = 'https://core-api.janbaskplatform-development.com'
        * def RequestBody = read('classpath:com/janbask/payloads/loginPayload.json') 
        

    Scenario: Login scenario
        Given path '/api/auth/login'
        And header origin = originURL
        And request RequestBody
        When method post
        Then status 200
        * print response
        And def token = response.data.token