Feature: Tests
  Functional Testing for API

  Scenario Outline: Functional Testing
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
      | 0      | [3, 3]   | [1, 1]        | [[0, 0]]                 | S            | [1, 0]      | 0          | 200      |
      | 1      | [3, 3]   | [1, 1]        | [[0, 0]]                 | E            | [2, 1]      | 0          | 200      |
      | 2      | [3, 3]   | [1, 1]        | [[0, 0]]                 | W            | [0, 1]      | 0          | 200      |
      | 500000 | [1, 1]   | [1, 1]        | [[0, 0]]                 | NESSWWNNES   | N\A         | -1         | 400      |


  Scenario Outline: Test Plan - Happy Path
    Given I provide the following cleaning session request: "<roomSize>" "<startLocation>" "<patches>" "<instructions>"
    When I create a cleaning scenario
    Then I get the following expected output: <httpCode> "<endLocation>" "<patchCount>"
    Examples:
      | number | roomSize | startLocation | patches          | instructions | endLocation | patchCount | httpCode |
      | 1      | [1, 1]   | [0, 0]        | []               | N            | [0, 0]      | 0          | 200      |
      | 2      | [1, 1]   | [0, 0]        | [[0, 0]]         | N            | [0, 0]      | 1          | 200      |
      | 3      | [1, 1]   | [0, 0]        | [[0, 0], [0, 0]] | N            | [0, 0]      | 1          | 200      |
      | 3      | [1, 1]   | [0, 0]        | [[0, 0], [0, 0]] |              | [0, 0]      | 1          | 200      |

  Scenario Outline: Test Plan - Sad Path
    Given I provide the following cleaning session request: "<roomSize>" "<startLocation>" "<patches>" "<instructions>"
    When I create a cleaning scenario
    Then I get the following expected output: <httpCode> "<endLocation>" "<patchCount>"
    Examples:
      | number | roomSize | startLocation | patches          | instructions | endLocation | patchCount | httpCode |
      | 1      | null     | [0, 0]        | []               | N            | N/A         | -1         | 400      |
      | 2      | [0, 0]   | [0, 0]        | [[0, 0]]         | N            | N/A         | -1         | 400      |
      | 3      | [0, 0]   | [0, 0]        | [[0, 0], [0, 0]] | N            | N/A         | -1         | 400      |
      | 4      | [-1, -1] | [0, 0]        | []               |              | N/A         | -1         | 400      |
      | 5      | [2, 2]   | [-1, 0]       | []               |              | N/A         | -1         | 400      |
      | 6      | [2, 2]   | [0, -1]       | []               |              | N/A         | -1         | 400      |
      | 7      | [2, 2]   | [3, 1]        | []               |              | N/A         | -1         | 400      |
      | 8      | [2, 2]   | [1, 3]        | []               |              | N/A         | -1         | 400      |
      | 9      | [1, 1]   | null          | []               | N            | N/A         | -1         | 400      |
      | 10     | [1,1]    | [0, 0]        | null             | N            | N/A         | -1         | 400      |

