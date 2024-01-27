package com.chris.co.app.model;

import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.cucumber.core.internal.com.fasterxml.jackson.databind.ObjectMapper;

public abstract class PojoBase<T> {
    public String toJson() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(this);
    }

    public <T extends PojoBase> T fromJson(String jsonString) throws JsonProcessingException {
        return (T) new ObjectMapper().readValue(jsonString, this.getClass());
    }
}
