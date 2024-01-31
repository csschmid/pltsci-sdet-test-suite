package com.chris.co.app.model;

import lombok.*;

import static com.chris.co.app.utils.Utils.parseIntArray;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EqualsAndHashCode
public class CleaningSessionResponse extends PojoBase {
    private int[] coords;
    private int patches;

    public CleaningSessionResponse(String coords, String patches) {
        this.coords = parseIntArray(coords);
        this.patches = Integer.parseInt(patches);
    }
}
