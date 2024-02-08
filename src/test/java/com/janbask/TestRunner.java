package com.janbask;
import com.intuit.karate.junit5.Karate;

class TestRunner {

 @Karate.Test
 Karate test() {
 return Karate.run("login").relativeTo(getClass());
 }
}