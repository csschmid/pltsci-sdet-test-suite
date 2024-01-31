package com.chris.co.app.steps;

import com.chris.co.app.api.CleaningSessionAPI;
import com.chris.co.app.model.CleaningSessionRequest;
import com.chris.co.app.model.CleaningSessionResponse;
import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.http.Headers;
import io.restassured.response.Response;
import org.junit.Assert;

import java.util.List;
import java.util.Optional;

import static com.chris.co.app.utils.Utils.replaceNulls;

public class CukeSteps {
    CleaningSessionAPI cleaningSessionAPI = CleaningSessionAPI.builder().build();
    CleaningSessionRequest cleaningSessionRequest;
    String request;
    Optional<Headers> headers = Optional.empty();
    CleaningSessionResponse expectedResponse;
    Response actualResponse;

    @Given("I provide the following cleaning session request: {string} {string} {string} {string}")
    public void provideCleaningSessionRequest(String roomSize,
                                                           String coords,
                                                           String patches,
                                                           String instructions) throws JsonProcessingException {
        cleaningSessionRequest = new CleaningSessionRequest(roomSize, coords, patches, instructions);
        request = cleaningSessionRequest.toJson();
    }

    @Given("I provide the following json: {string}")
    public void provideRawJson(String json){
        request = json;
    }

    @When("I create a cleaning scenario")
    public void createCleaningScenario() throws JsonProcessingException {
        actualResponse = cleaningSessionAPI.createCleaningSession(headers, request);
    }

    @Then("I get the following expected output: {int} {string} {string}")
    public void getExpectedOutput(int httpCode, String coords, String patches) throws JsonProcessingException {
        Assert.assertEquals(
                String.format("Did not get expected http code.\nInput: %s\nOutput: %s",
                        request,
                        actualResponse.getBody().asString()),
                httpCode,
                actualResponse.getStatusCode());

        if (httpCode == 200) {
            expectedResponse = new CleaningSessionResponse(coords, patches);
            checkOutput(expectedResponse);
        }
    }

    private void checkOutput(CleaningSessionResponse expectedResponse) throws JsonProcessingException {
        CleaningSessionResponse actualCleaningSessionResponse = CleaningSessionResponse.fromJson(
                actualResponse.getBody().asString(),
                CleaningSessionResponse.class);
        Assert.assertEquals(
                String.format(
                        "\n" +
                                "Input:           %s\n" +
                                "Expected Output: %s\n" +
                                "Actual Output:   %s\n",
                        request,
                        expectedResponse,
                        actualCleaningSessionResponse),
                expectedResponse,
                actualCleaningSessionResponse);
    }
}
