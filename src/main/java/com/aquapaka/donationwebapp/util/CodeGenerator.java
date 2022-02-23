package com.aquapaka.donationwebapp.util;

import java.util.concurrent.ThreadLocalRandom;

public class CodeGenerator {
    private static final int MIN_CODE = 100000;
    private static final int MAX_CODE = 999999;

    private CodeGenerator() {
        throw new IllegalStateException("Util class!");
    }

    public static int generateCode() {
        return ThreadLocalRandom.current().nextInt(MIN_CODE, MAX_CODE + 1);        
    }
}
