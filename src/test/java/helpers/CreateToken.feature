
Feature: Create Token
       
        Background: Define URI
        * url 'https://core-api.janbaskplatform-development.com'   
       # * def loginRequestBody = read('classpath:com/janbask/runner/json/newArticleRequest.json')
        * def originURL = 'https://core-api.janbaskplatform-development.com' 


    Scenario: login scenario
        Given path '/api/auth/login'
        And header origin = originURL
        And request { 'email': 'rajat.singh@janbask.com', 'password': 'LKJmnb2000' } 
        When method post
        Then status 200
        * print response
        * def token = response.data.token