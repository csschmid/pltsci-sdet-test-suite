package com.chris.co.app.api;

import com.chris.co.app.model.CleaningSessionRequest;
import com.chris.co.app.model.CleaningSessionResponse;
import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.restassured.RestAssured;
import io.restassured.http.Header;
import io.restassured.http.Headers;
import io.restassured.http.Method;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.omg.CORBA.BAD_CONTEXT;

import static io.restassured.RestAssured.given;
import static io.restassured.RestAssured.head;

@Getter
@Builder
@AllArgsConstructor
public class CleaningSessionAPI {
    @Builder.Default
    private String BASE_URL = "localhost";
    @Builder.Default
    private int PORT = 8080;
    @Builder.Default
    private String cleaningSessionEndpoint = "v1/cleaning-sessions";
    @Builder.Default
    private final Headers DEFAULT_HEADERS = new Headers(
            new Header("Content-Type", "application/json")
    );

    public CleaningSessionResponse createCleaningSession(CleaningSessionRequest request) throws JsonProcessingException {
        Response response = createCleaningSession(DEFAULT_HEADERS, request.toJson());
        return (CleaningSessionResponse) CleaningSessionResponse.builder().build().fromJson(response.getBody().asString());
    }

    public Response createCleaningSession(Headers headers, String json) {
        RestAssured.baseURI = "http://" + BASE_URL;
        RequestSpecification reqSpec = RestAssured.given();
        reqSpec.port(PORT)
                .headers(headers)
                .body(json);
        return reqSpec.when().post(cleaningSessionEndpoint);
    }
}
