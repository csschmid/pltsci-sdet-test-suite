## Problem

Entering 3 values for a `coords` should result in a 400 user error code.

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
       curl -v -H 'Content-Type: application/json' -X POST -d '{"roomSize":[1, 1],"coords":[0, 0, 0],"patches":[[0,0]],"instructions":"N"}' http://localhost:8080/v1/cleaning-sessions
       ```
3. Notice a `200` response with a payload of `{"coords":[0,0],"patches":1}`

## Expectation

Entering three values for a `coords` is invalid and should result in a 400 error.

## Impact

Invalid contract input should be rejected so that consumers do not begin to rely on improper design, causing issues in
the future.
Taken alone, this would not necessarily be a blocker for release, but something that should be addressed.
However, with incorrect counts being seen in other fields, this set of bugs should be addressed before release.
