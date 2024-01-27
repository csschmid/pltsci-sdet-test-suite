# Test Plan
## Introduction
### Goals
Validate the correctness of the cleaning service.

#### Requirements
1. Input requirements
   1. Input should be a json payload of the type
      1. ```JSON
          {
            "roomSize" : [<int>, <int>],
            "coords" : [<int>, <int>],
            "patches": [
              [<int>, <int>],
              ...
            ],
            "instructions" : "[N|S|E|W]*"
          }
          ```
   2. Constraints
      1. `0 <= roomSize[0] <= Integer.MAX_SIZE`
      2. `0 <= roomSize[1] <= Integer.MAX_SIZE`
      3. `0 <= coord[0] <= roomSize[0]`
      4. `0 <= coord[1] <= roomSize[1]`
      5. `0 <= patches[i][0] <= roomSize[0]`
      6. `0 <= patches[i][1] <= roomSize[1]`
2. Output requirements
   1. Output should be a json payload of the type
      1. ```JSON
         {
           "coords" : [<int>, <int>],
           "patches" : <int>
         }
         ```
   2. Constraints
      1. `0 <= coords[0] <= roomSize[0]`
      2. `0 <= coords[1] <= roomSize[1]`
      3. `0 <= patches <= roomSize.length * roomSize[0].length`
      4. patches only counts the dirt patches that the roomba would have traversed, not necessarily all patches in the room

### Scope
1. The functional correctness of the service
2. Adherence to the specified contract

#### Out-of-Scope
1. Build, deployment, and release of service
2. Service configuration
3. Any authentication or authorization gating access to the Rest endpoint
4. Time and memory performance of the system

## Approach
### Methodology
1. Cucumber Gherkins will be employed
   2. Gherkins listed below will be created for testing
2. A failed test will provide input, expected, and actual output for the report in order to allow for easier bug reporting and investigation
3. POJO serialization / deserialization will be used to provide a clean data model for testing
4. RestAssured will be used to simplify access to the endpoints

### Test Cases
#### Happy Path
1. Empty room
2. 1x1 room with no patches
3. 1x1 room with patches
4. 1x1 room with duplicate patches
5. Empty instructions

#### Sad Path
1. Null roomSize
2. Empty roomSize with 1 patch
3. Empty roomSize with duplicate patches
4. Negative room size
5. Negative coord value
6. Coord value larger than roomSize
7. RoomSize larger than an integer value
8. Coordinate larger than an integer value
9. Three values for roomSize
10. One value for roomSize
11. Three values for coords
12. One value for coords
13. Null patches array entry
14. Null patches total array
15. Three values for patches entry
16. One value for patches entry
17. Null instructions
18. Instructions containing lowercase valid letters
19. Instructions containing invalid letters
20. Instructions containing unicode letters

### Test Data
#### Gherkins
##### Happy Path
##### Sad Path

## Appendix
### Glossary
| Term                              | Definition                                                                                                                                                                                   |
|-----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Behavior Driven Development (BDD) | A methodology to where testing is performed on a service by defining behavior                                                                                                                |
| Cucumber                          | A testing framework which implements BDD                                                                                                                                                     |
| Gherkin                           | A method of defining a BDD test using Cucumber. These uses terms "Scenario", "Given", "When", and "Then" to define groups of tests, setup, actions, and validation for output (respectively). |

### Open Questions
1. What error codes should be returned for invalid user input (i.e. what 4XX codes)?
2. What error codes should be returned for server side failures (i.e. what 5XX codes)?
3. Are their any limits to the size of the room?

### Assumptions
1. Assumptions about the Input:
   1. Json input
      1. `roomSize`: an array of 2 integers representing denoting row and column lengths for the room
      2. `coords`: an array of 2 integers representing the start location of the roomba
      3. `patches`: an array of 2 integer arrays [x, y] representing the locations of the dirt patches in the room
      4. `instructions`: a string whose characters are in the set [N, S, E, W] which represent the in order operations for movement around the room
   2. Invalid json input will return a 404
   3. All input parameters are required, and are not null
   4. Patches array may have duplicate values
   5. Duplicate patches are only counted once if included in roomba instruction path
2. Assumptions about the Output:
   1. Json Output
      1. `coords`: an array of 2 integers represeting the ending location of the roomba after it executes the instructions
      2. `patches`: a single integer representing the count of dirt patches cleaned
   2. All output parameters are required, and are not null

### Resources
- [Original Assignment](https://bitbucket.org/platformscience/pltsci-sdet-assignment/src/main/)
- [GitHub Solution]()
