Feature: Tests
  Functional Testing for API

  Scenario Outline: Functional Testing: number <number>
    Given I provide the following cleaning session request: "<roomSize>" "<startLocation>" "<patches>" "<instructions>"
    When I create a cleaning scenario
    Then I get the following expected output: <httpCode> "<endLocation>" "<patchCount>"
    Examples:
      | number | roomSize | startLocation | patches                  | instructions | endLocation | patchCount | httpCode |
      | 1      | [1, 1]   | [0, 0]        | [[0, 0]]                 | NSEW         | [0, 0]      | 1          | 200      |
      | 2      | [2, 2]   | [0, 0]        | [[1, 1]]                 | EN           | [1, 1]      | 1          | 200      |
      | 3      | [2, 2]   | [0, 0]        | [[0, 0], [0, 1]]         | EN           | [1, 1]      | 1          | 200      |
      | 4      | [3, 3]   | [1, 1]        | [[0, 0], [1, 2], [3, 4]] | NESSWWNNES   | [1, 1]      | 3          | 200      |
      | 5      | [1, 10]  | [0, 0]        | [[0, 5]]                 | NNNNNNNNNN   | [0, 9]      | 1          | 200      |
      | 6      | [1, 10]  | [0, 9]        | [[0, 5]]                 | SSSSSSSSSS   | [0, 0]      | 1          | 200      |
      | 7      | [10, 1]  | [0, 0]        | [[5, 0]]                 | EEEEEEEEEE   | [9, 0]      | 1          | 200      |
      | 8      | [10, 1]  | [9, 0]        | [[5, 0]]                 | WWWWWWWWWW   | [0, 0]      | 1          | 200      |
      | 9      | [3, 3]   | [1, 1]        | [[0, 0]]                 | N            | [1, 2]      | 0          | 200      |
      | 10     | [3, 3]   | [1, 1]        | [[0, 0]]                 | S            | [1, 0]      | 0          | 200      |
      | 11     | [3, 3]   | [1, 1]        | [[0, 0]]                 | E            | [2, 1]      | 0          | 200      |
      | 12     | [3, 3]   | [1, 1]        | [[0, 0]]                 | W            | [0, 1]      | 0          | 200      |
      | 13     | [1, 1]   | [1, 1]        | [[0, 0]]                 | NESSWWNNES   | N\A         | -1         | 400      |

  Scenario Outline: Test Plan - Happy Path: number <number>
    Given I provide the following cleaning session request: "<roomSize>" "<startLocation>" "<patches>" "<instructions>"
    When I create a cleaning scenario
    Then I get the following expected output: <httpCode> "<endLocation>" "<patchCount>"
    Examples:
      | number | roomSize | startLocation | patches          | instructions | endLocation | patchCount | httpCode |
      | 1      | [1, 1]   | [0, 0]        | []               | N            | [0, 0]      | 0          | 200      |
      | 2      | [1, 1]   | [0, 0]        | [[0, 0]]         | N            | [0, 0]      | 1          | 200      |
      | 3      | [1, 1]   | [0, 0]        | [[0, 0], [0, 0]] | N            | [0, 0]      | 1          | 200      |
      | 4      | [1, 1]   | [0, 0]        | [[0, 0]]         |              | [0, 0]      | 0          | 200      |
      | 5      | [1, 2]   | [0, 0]        | [[0, 1]]         | NSNSNSNS     | [0, 0]      | 1          | 200      |

  Scenario Outline: Test Plan - Sad Path: number <number>
    Given I provide the following cleaning session request: "<roomSize>" "<startLocation>" "<patches>" "<instructions>"
    When I create a cleaning scenario
    Then I get the following expected output: <httpCode> "<endLocation>" "<patchCount>"
    Examples:
      | number | roomSize | startLocation | patches          | instructions | endLocation | patchCount | httpCode |
      | 1      | null     | [0, 0]        | []               | N            | N/A         | -1         | 400      |
      | 2      | [0, 0]   | [0, 0]        | [[0, 0]]         | N            | N/A         | -1         | 400      |
      | 3      | [0, 0]   | [0, 0]        | [[0, 0], [0, 0]] | N            | N/A         | -1         | 400      |
      | 4      | [-1, 0]  | [0, 0]        | []               | N            | N/A         | -1         | 400      |
      | 5      | [0, -1]  | [0, 0]        | []               | N            | N/A         | -1         | 400      |
      | 6      | [2, 2]   | [-1, 0]       | []               | N            | N/A         | -1         | 400      |
      | 7      | [2, 2]   | [0, -1]       | []               | N            | N/A         | -1         | 400      |
      | 8      | [2, 2]   | [3, 1]        | []               | N            | N/A         | -1         | 400      |
      | 9      | [2, 2]   | [1, 3]        | []               | N            | N/A         | -1         | 400      |
      | 10     | [1, 1]   | null          | []               | N            | N/A         | -1         | 400      |
      | 11     | [1,1]    | [0, 0]        | null             | N            | N/A         | -1         | 400      |
      | 12     | [1,1]    | [0, 0]        | [[0, 0], null]   | N            | N/A         | -1         | 400      |
      | 13     | [1,1]    | [0, 0]        | [[0, 0]]         | null         | N/A         | -1         | 400      |

  Scenario Outline: Test Plan - Sad Path: number <number>
    Given I provide the following json: '<jsonRequest>'
    When I create a cleaning scenario
    Then I get the following expected output: <httpCode> "<endLocation>" "<patchCount>"
    Examples:
      | number | jsonRequest                                                                       | endLocation | patchCount | httpCode |
      | 14     | {"roomSize":[2147483648 ,1],"coords":[0,0],"patches":[[0,0]],"instructions":"N"}  | N/A         | -1         | 400      |
      | 15     | {"roomSize":[1, 2147483648],"coords":[0,0],"patches":[[0,0]],"instructions":"N"}  | N/A         | -1         | 400      |
      | 16     | {"roomSize":[1, 1],"coords":[2147483648,0],"patches":[[0,0]],"instructions":"N"}  | N/A         | -1         | 400      |
      | 17     | {"roomSize":[1, 1],"coords":[0, 2147483648],"patches":[[0,0]],"instructions":"N"} | N/A         | -1         | 400      |
      | 18     | {"roomSize":[1, 1, 1],"coords":[0, 0],"patches":[[0,0]],"instructions":"N"}       | N/A         | -1         | 400      |
      | 19     | {"roomSize":[1],"coords":[0, 0],"patches":[[0,0]],"instructions":"N"}             | N/A         | -1         | 400      |
      | 20     | {"roomSize":[1, 1],"coords":[0, 0, 0],"patches":[[0,0]],"instructions":"N"}       | N/A         | -1         | 400      |
      | 21     | {"roomSize":[1, 1],"coords":[0],"patches":[[0,0]],"instructions":"N"}             | N/A         | -1         | 400      |
      | 22     | {"roomSize":[1, 1],"coords":[0, 0],"patches":[[0,0,0]],"instructions":"N"}        | N/A         | -1         | 400      |
      | 23     | {"roomSize":[1, 1],"coords":[0, 0],"patches":[[0]],"instructions":"N"}            | N/A         | -1         | 400      |
      | 24     | {"roomSize":[1, 1],"coords":[0, 0],"patches":[[0, 0]],"instructions":"news"}      | N/A         | -1         | 400      |
      | 25     | {"roomSize":[1, 1],"coords":[0, 0],"patches":[[0, 0]],"instructions":"cool"}      | N/A         | -1         | 400      |
      | 26     | {"roomSize":[1, 1],"coords":[0, 0],"patches":[[0, 0]],"instructions":"☺"}         | N/A         | -1         | 400      |
      | 27     | {"roomSize":[0 ,0],"coords":[],"patches":[],"instructions":"N"}  | N/A         | -1         | 400      |
