package com.chris.co.app.model;

import io.cucumber.core.internal.com.fasterxml.jackson.core.JsonProcessingException;
import io.cucumber.core.internal.com.fasterxml.jackson.databind.ObjectMapper;

public abstract class PojoBase<T> {
    public String toJson() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(this);
    }

    public static <T extends PojoBase> T fromJson(String jsonString, Class clazz) throws JsonProcessingException {
        return (T) new ObjectMapper().readValue(jsonString, clazz);
    }

    @Override
    public String toString() {
        try {
            return this.toJson();
        } catch (JsonProcessingException e) {
            return super.toString();
        }
    }
}
