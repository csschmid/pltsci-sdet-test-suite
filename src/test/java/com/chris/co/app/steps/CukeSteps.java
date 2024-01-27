package com.chris.co.app.steps;

import com.chris.co.app.api.CleaningSessionAPI;
import com.chris.co.app.model.CleaningSessionRequest;
import com.chris.co.app.model.CleaningSessionResponse;
import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.Assert;

public class CukeSteps {
    public final CleaningSessionRequest DEFAULT_CLEANING_SESSION_REQUEST = CleaningSessionRequest.builder()
//            .roomSize(new int[]{5,5})
//            .coords(new int[]{1, 2})
//            .patches(new int[][]{{1, 0}, {2, 2}, {2, 3}})
//            .instructions("NNESEESWNWW")
            .roomSize(new int[]{3, 3})
            .coords(new int[]{1, 1})
            .patches(new int[][]{
//                    {0, 0},
//                    {0, 1},
//                    {2, 0},
                    {2, 1}
            })
            .instructions("NESSWWNNES")
            .build();
    public final CleaningSessionResponse DEFAULT_EXPECTED_CLEANING_SESSION_RESPONSE = CleaningSessionResponse.builder()
            .coords(new int[]{1, 1})
            .patches(4)
            .build();

    CleaningSessionAPI cleaningSessionAPI = CleaningSessionAPI.builder().build();
    CleaningSessionRequest request;
    CleaningSessionResponse expectedResponse;
    CleaningSessionResponse actualResponse;

    @Given("I provide a {string} cleaning session request")
    public void provideACleaningSessionRequest(String requestName) {
        if("default".equals(requestName)) {
            request = DEFAULT_CLEANING_SESSION_REQUEST;
        } else {
            request = CleaningSessionRequest.builder().build();
        }
    }

    @When("I create a cleaning scenario")
    public void createCleaningScenario() throws JsonProcessingException {
        actualResponse = cleaningSessionAPI.createCleaningSession(request);
    }

    @Then("I should see a {string} response")
    public void checkResponse(String outcome) {
        switch(outcome) {
            case "successful":
                Assert.assertNotNull(actualResponse);
                break;
            default:
                break;
        }
    }

    @Then("The response should match {string}")
    public void checkCleaningSessionResponse(String outcome) {
        if("default".equals(outcome)) {
            expectedResponse = DEFAULT_EXPECTED_CLEANING_SESSION_RESPONSE;
        } else {
            expectedResponse = CleaningSessionResponse.builder().build();
        }

        Assert.assertEquals(
                String.format(
                        "Input: %s\nExpected Output: %s\nActual Output: %s",
                        request,
                        expectedResponse,
                        actualResponse),
                expectedResponse,
                actualResponse);
    }
}
