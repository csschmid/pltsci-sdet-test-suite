package com.chris.co.app.model;

import lombok.*;

import static com.chris.co.app.utils.Utils.parse2DIntArray;
import static com.chris.co.app.utils.Utils.parseIntArray;

@Getter
@Builder
@AllArgsConstructor
@EqualsAndHashCode
public class CleaningSessionRequest extends PojoBase {
    private int[] roomSize;
    private int[] coords;
    private int[][] patches;
    private String instructions;
    
    public CleaningSessionRequest(String roomSize, String coords, String patches, String instructions) {
        this.roomSize = parseIntArray(roomSize);
        this.coords = parseIntArray(coords);
        this.patches = parse2DIntArray(patches);
        this.instructions = instructions;
    }
}
