package br.com.midnightsyslabs.flow_control.dto;

public enum ClientCategory {
    PERSONAL('p'),
    COMPANY('c'),
    UNDEFINED('u');

    private final char code;

    ClientCategory(char code) {
        this.code = code;
    }

    public char getCode() {
        return code;
    }

    public static ClientCategory fromCode(char code) {
        for (ClientCategory category : ClientCategory.values()) {
            if (category.getCode() == code) {
                return category;
            }
        }
        return UNDEFINED;
    }
}
