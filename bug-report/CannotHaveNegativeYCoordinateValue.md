## Problem

Negative `y` values for `coord` should result in a 400 user error code.

## More Information

Per the specification of the service:
> [The] room is divided up in a grid based on these dimensions; a room that has dimensions X: 5 and Y: 5 has 5 columns and 5 rows, so 25 possible hoover positions. The bottom left corner is the point of origin for our coordinate system, so as the room contains all coordinates its bottom left corner is defined by X: 0 and Y: 0.

The following constraints follow from the spec:
`0 <= coord[x] <= roomSize[x]`
`0 <= coord[y] <= roomSize[y]`
`x=0, y=1`

## Steps to Reproduce

1. Start the service locally
2. Send the following curl
    1. ```shell 
       curl -v -H 'Content-Type: application/json' -X POST -d '{"roomSize":[2,2],"coords":[0,-1],"patches":[],"instructions":"N"}' http://localhost:8080/v1/cleaning-sessions
       ```
3. Notice a `200` response with a payload of `{"coords":[0,0],"patches":0}`

## Expectation

It is expected that a 400, non-retryable error is generated to let the user know their input was incorrect. The lower left corner (south-western) should be `[0, 0]`. Therefor, there should be no coordinates less than `0`.

## Impact

Allowing negative numbers allows for a starting coordinate to be placed "outside" the room, invalidating the execution
of instructions

This is a blocking issue as invalid values may lead to undefined behavior
