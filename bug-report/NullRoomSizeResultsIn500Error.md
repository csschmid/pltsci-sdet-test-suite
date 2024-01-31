## Problem

Entering `null` value for `roomSize` should not result in a 500 error.

## More Information

While not explicitly called out in the specification, returning a server side failure for invalid user input allows for the user to retry the bad input without realizing they are at fault.

## Steps to Reproduce

1. Start the service locally
2. Send the following curl
    1. ```shell 
       curl -v -H 'Content-Type: application/json' -X POST -d '{"roomSize":null,"coords":[0,0],"patches":[],"instructions":"N"}' http://localhost:8080/v1/cleaning-sessions
       ```
3. Notice a `500` response

## Expectation
Entering a null value for a roomSize is invalid user input and should result in a 400 user error instead of a server side 500.

## Impact

Invalid input from a user may be retried, as it appears to be a server side issue instead of being user cause.

This probably should be a blocking issue as it is invalid REST design, and may result in incorrect metrics, incorrect logs, and in the worst case pages for the development team for improper user interaction.