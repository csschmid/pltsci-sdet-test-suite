package com.chris.co.app.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CleaningSessionResponse extends PojoBase {
    private int[] coords;
    private int patches;
}
