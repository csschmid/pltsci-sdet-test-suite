## Problem

Entering 1 values for a `roomSize` should not result in a 500 server error code, but instead a 400 user error code.

## More Information

Per the specification:

> Input
> Program input will be received in a json payload with the format described here.

    Example: 
    {
        "roomSize" : [5, 5],
        "coords" : [1, 2],
        "patches" : [
            [1, 0],
            [2, 2],
            [2, 3]
        ],
        "instructions" : "NNESEESWNWW"
    }

## Steps to Reproduce

1. Start the service locally
2. Send the following curl
    1. ```shell 
       curl -v -H 'Content-Type: application/json' -X POST -d '{"roomSize":[1],"coords":[0, 0],"patches":[[0,0]],"instructions":"N"}' http://localhost:8080/v1/cleaning-sessions
       ```
3. Notice a `500` response

## Expectation

Entering only a single value for a `roomSize` is invalid and should result in a 400 error.

## Impact

Invalid input from a user may be retried, as it appears to be a server side issue instead of being user cause.

This probably should be a blocking issue as it is invalid REST design, and may result in incorrect metrics, incorrect logs, and in the worst case pages for the development team for improper user interaction.