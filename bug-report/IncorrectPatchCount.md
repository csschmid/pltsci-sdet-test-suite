## Problem
Patches count in response does not correctly count the number of patches that should be visited.

## Steps to Reproduce

1. Start the service locally
2. Send the following curl
    1. ```shell 
       curl -v -H 'Content-Type: application/json' -X POST -d '{"roomSize":[3,3],"coords":[1,1],"patches":[[0,0],[1,2],[3,4]],"instructions":"NESSWWNNES"}' http://localhost:8080/v1/cleaning-sessions
       ```
3. Notice a `200` response with a payload of `{"coords":[1,1],"patches":2}`
  1. Expectation is `200` response with a payload of `{"coords":[1,1],"patches":3}` as each patch should have been visited
4. Rerun test suite for more extensive results

## Expectation

Patch count returned in response should correspond to the number of patches that the roomba has entered. It should not be influence by previous values, nor should it be influence by direction the patch is entered.

## Impact

Blocking issue as the service's functionality is incorrect in certain cases.