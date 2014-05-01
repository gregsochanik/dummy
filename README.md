dummy
=====

A very basic web app that allows you to assert that your deployment scripts are wokring as expected.

Simply run the scripts and verify that the site has been set up and is running by curling the ~/_service/status endpoint.

You can even add env={EXPECTED_ENVIRONMENT} to the end to assert that the expected environment setup has been deployed. 

The service will return a 409 Conflict along with a message to that effect if incorrect.


