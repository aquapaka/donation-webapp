package com.aquapaka.donationwebapp.validator;

public class AppUserValidator {
    /**
        ^[a-zA-Z0-9]      # start with an alphanumeric character
        (                 # start of (group 1)
            [._-](?![._-])  # follow by a dot, hyphen, or underscore, negative lookahead to
                            # ensures dot, hyphen, and underscore does not appear consecutively
            |               # or
            [a-zA-Z0-9]     # an alphanumeric character
        )                 # end of (group 1)
        {3,18}            # ensures the length of (group 1) between 3 and 18
        [a-zA-Z0-9]$      # end with an alphanumeric character

                            # {3,18} plus the first and last alphanumeric characters,
                            # total length became {5,20}
     */
    private static final String USERNAME_PATTERN = "^[a-zA-Z0-9]{5,20}$";
    /**
        (?=.{1,64}@)            # local-part min 1 max 64

        [A-Za-z0-9_-]+          # Start with chars in the bracket [ ], one or more (+)
                                # dot (.) not in the bracket[], it can't start with a dot (.)

        (\\.[A-Za-z0-9_-]+)*	# follow by a dot (.), then chars in the bracket [ ] one or more (+)
                                # * means this is optional
                                # this rule for two dots (.)

        @                       # must contains a @ symbol

        [^-]                    # domain can't start with a hyphen (-)

        [A-Za-z0-9-]+           # Start with chars in the bracket [ ], one or more (+)     

        (\\.[A-Za-z0-9-]+)*     # follow by a dot (.), optional

        (\\.[A-Za-z]{2,})       # the last tld, chars in the bracket [ ], min 2
     */
    private static final String EMAIL_PATTERN = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";
    /**
      ^                                   # start of line
        (?=.*[0-9])                       # positive lookahead, digit [0-9]
        (?=.*[a-z])                       # positive lookahead, one lowercase character [a-z]
        (?=.*[A-Z])                       # positive lookahead, one uppercase character [A-Z]
        (?=.*[!@#&()–[{}]:;',?/*~$^+=<>]) # positive lookahead, one of the special character in this [..]
        .                                 # matches anything
        {8,20}                            # length at least 8 characters and maximum of 20 characters
      $                                   # end of line
     */
    private static final String PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,20}$";

    public static boolean isValidUsername(String username) {
        return username.matches(USERNAME_PATTERN);
    }

    public static boolean isValidEmail(String email) {
        return email.matches(EMAIL_PATTERN);
    }

    public static boolean isValidPassword(String password) {
        return password.matches(PASSWORD_PATTERN);
    }
}
