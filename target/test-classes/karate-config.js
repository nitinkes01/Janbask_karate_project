function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
   karate.configure('connectTimeout', 120000);
    karate.configure('readTimeout', 120000);
    

 
  if (!env) {
    env = 'dev';
  }
  var config = {
	  apiUrl: 'https://core-api.janbaskplatform-development.com',
  }

  if (env == 'dev') {
    config.userEmail = ''
    config.userPassword = ''
  } 
  if (env == 'qa') {
    config.userEmail = ''
    config.userPassword = ''
  }

 // var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  //karate.configure('headers', {Authorization: 'Token ' + accessToken})
   
   
  return config;
}