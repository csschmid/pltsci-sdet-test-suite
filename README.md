# Platform Science SDET Test Suite

## Execution

The execution script can be found under `scripts/run.sh` located here: [run.sh](scripts%2Frun.sh)

### Script Execution Assumptions

1. This script assumes it is executing from within the root directory of the test suite project,
   and that one directory up, there exists the project directory for `pltsci-sdet-assignment`
2. The system has the following installed and accessible via commandline:
    1. docker
    2. awk
    3. mvn (maven)
    4. firefox

## Documentation

A test plan can be found under the `doc` directory here: [TestPlan.md](doc%2FTestPlan.md)

## Bugs

Bug reports for the `pltsci-sdet-assignment` project, found by this suite, can be found under the `bug-report`
directory, here: [bug-report](bug-report)

## Development Setup

This project uses Maven, and takes advantage of the [Lombok annotation library](https://projectlombok.org/) to reduce
boilerplate code.

### Structure

- Request and Response model files can be found under `src/main/java/com/chris/co/app/model`
    - The model takes advantage of POJO (Plain Old Java Objects) to model the resquest and response object for easier
      authorship and assertion.
- API interactions are modeled in the `src/main/java/com/chris/co/app/api` directory
    - RestAssured is utilized to perform interaction with REST endpoint(s)
- General utilities can be found under `src/main/java/com/chris/co/app/utils`
- Cucumber Feature files can be found under `src/test/resoruces/features`
- Cucumber Steps can be found under `src/test/java/com/chris/co/app/steps`
- A TestRunner class is employed to allow for integration of Cucumber with junit for easy maven execution
  with `mvn test`. This can be found under `src/test/java/com/chris/co/app/runner` 