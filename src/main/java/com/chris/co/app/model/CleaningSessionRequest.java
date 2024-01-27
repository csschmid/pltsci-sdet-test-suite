package com.chris.co.app.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CleaningSessionRequest extends PojoBase {
    private int[] roomSize;
    private int[] coords;
    private int[][] patches;
    private String instructions;
}
