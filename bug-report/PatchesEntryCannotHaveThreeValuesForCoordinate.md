## Problem

Entering 3 values for a patch location should result in a 400 error.

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
       curl -v -H 'Content-Type: application/json' -X POST -d '{"roomSize":[-1,-1],"coords":[0,0],"patches":[],"instructions":""}' http://localhost:8080/v1/cleaning-sessions
       ```
3. Notice a `200` response with a payload of `{"coords":[0,0],"patches":0}`

## Expectation

Entering three values for a patch entry is invalid and should result in a 400 error.

## Impact

Invalid contract input should be rejected so that consumers do not begin to rely on improper design, causing issues in
the future.
Not necessarily a blocker for release, but something that should be addressed.
