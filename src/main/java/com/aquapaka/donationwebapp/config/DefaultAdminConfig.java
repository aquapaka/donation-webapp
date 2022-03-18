package com.aquapaka.donationwebapp.config;

import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.model.state.Gender;
import com.aquapaka.donationwebapp.model.state.Role;
import com.aquapaka.donationwebapp.repository.AppUserRepository;
import com.aquapaka.donationwebapp.util.PasswordEncrypt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.EventListener;

@Configuration
public class DefaultAdminConfig {
    private static final String ADMIN_EMAIL = "admin@donation.com";
    private static final String ADMIN_PASSWORD = "AdminPass195838!";

    @Autowired
    private AppUserRepository appUserRepository;

    @EventListener(ApplicationReadyEvent.class)
    public void setupAdminAccount() throws NoSuchAlgorithmException {
        String encryptedPassword = PasswordEncrypt.encryptPassword(ADMIN_PASSWORD);
        if(appUserRepository.findAppUserByEmail(ADMIN_EMAIL).isPresent()) return;

        AppUser appUser = new AppUser(ADMIN_EMAIL, encryptedPassword, "admin", "Admin", LocalDate.now(), Gender.NOT_SET, "not set", Role.ADMIN, AppUserState.ACTIVE, 0);
        appUserRepository.save(appUser);
    }
}
