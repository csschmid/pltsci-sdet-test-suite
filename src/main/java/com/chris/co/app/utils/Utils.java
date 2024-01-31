package com.chris.co.app.utils;

import java.util.ArrayList;
import java.util.List;

public class Utils {
    public static int[] parseIntArray(String intArrayString) {
        if(intArrayString == null || "null".equals(intArrayString)) {
            return null;
        }
        intArrayString = intArrayString.replaceAll("\\[", "").replaceAll("]", "").replaceAll(" ", "");
        String[] ints = intArrayString.split(",");
        int[] ans = new int[ints.length];
        int i = 0;
        for(String value : ints) {
            ans[i] = Integer.parseInt(value);
            i++;
        }
        return ans;
    }

    public static int[][] parse2DIntArray(String twoDIntArray) {
        if(twoDIntArray == null || "null".equals(twoDIntArray)) {
            return null;
        }
        List<int[]> twoDIntList = new ArrayList<>();
        StringBuilder sb = new StringBuilder();
        boolean reading = false;
        for(int i = 1; i < twoDIntArray.length() - 1; i++) {
            if(twoDIntArray.charAt(i) == '[') {
                reading = true;
            }
            if(reading) {
                sb.append(twoDIntArray.charAt(i));
            }
            if(twoDIntArray.charAt(i) == ']') {
                reading = false;
                twoDIntList.add(parseIntArray(sb.toString()));
                sb = new StringBuilder();
            }
        }

        return twoDListToArray(twoDIntList);
    }

    private static int[][] twoDListToArray(List<int[]> twoDList) {
        if(twoDList == null) {
            return null;
        }
        if(twoDList.size() < 1) {
            return new int[0][0];
        }
        int[][] ans = new int[twoDList.size()][twoDList.get(0).length];

        for(int i = 0; i < twoDList.size(); i++) {
            ans[i] = twoDList.get(i);
        }
        return ans;
    }

    public static List<String> replaceNulls(List<String> inputList) {
        // replace "null" with null
        for(int i = 0; i < inputList.size(); i++) {
            if(inputList.get(i) == "null") {
                inputList.set(i, null);
            }
        }
        return inputList;
    }
}
