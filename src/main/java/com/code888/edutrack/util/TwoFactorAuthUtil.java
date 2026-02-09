package com.code888.edutrack.util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.ByteBuffer;
import java.security.GeneralSecurityException;
import java.security.SecureRandom;
import java.util.Base64;

public class TwoFactorAuthUtil {

    private static final int SECRET_SIZE = 20;
    private static final int TIME_STEP = 30; // 30 seconds
    private static final int DIGITS = 6;

    public static String generateSecret() {
        byte[] buffer = new byte[SECRET_SIZE];
        new SecureRandom().nextBytes(buffer);
        return Base64.getEncoder().encodeToString(buffer).substring(0, 32);
    }

    public static boolean verifyCode(String secret, String code) {
        if (code == null || code.length() != DIGITS) {
            return false;
        }
        try {
            long currentInterval = System.currentTimeMillis() / 1000 / TIME_STEP;
            // Check current, previous, and next intervals to allow for clock drift
            for (int i = -1; i <= 1; i++) {
                if (generateTOTP(secret, currentInterval + i).equals(code)) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private static String generateTOTP(String secret, long interval) throws GeneralSecurityException {
        byte[] key = Base64.getDecoder().decode(secret);
        byte[] data = ByteBuffer.allocate(8).putLong(interval).array();

        Mac mac = Mac.getInstance("HmacSHA1");
        mac.init(new SecretKeySpec(key, "HmacSHA1"));
        byte[] hash = mac.doFinal(data);

        int offset = hash[hash.length - 1] & 0xf;
        int binary = ((hash[offset] & 0x7f) << 24) |
                ((hash[offset + 2] & 0xff) << 8) |
                ((hash[offset + 1] & 0xff) << 16) |
                (hash[offset + 3] & 0xff);

        int otp = binary % (int) Math.pow(10, DIGITS);
        String result = Integer.toString(otp);
        while (result.length() < DIGITS) {
            result = "0" + result;
        }
        return result;
    }
}
