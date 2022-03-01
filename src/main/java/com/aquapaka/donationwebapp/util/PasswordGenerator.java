package com.aquapaka.donationwebapp.util;

import java.util.Random;

public class PasswordGenerator {
    private static final int PASSWORD_LENGTH = 12;
    
    private PasswordGenerator() {
        throw new IllegalStateException("Utility class");
    }

    public static String generatePassword() {
        int leftLimit = 48; // letter '0'
        int rightLimit = 122; // letter 'z'
        Random random = new Random();

        return random.ints(leftLimit, rightLimit + 1)
                .limit(PASSWORD_LENGTH)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
    }
}
