package com.aquapaka.donationwebapp.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.status.RegisterStatus;
import com.aquapaka.donationwebapp.repository.AppUserRepository;
import com.aquapaka.donationwebapp.validator.AppUserValidator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppUserService {
    
    @Autowired
    private AppUserRepository appUserRepository;

    public List<AppUser> getAppUsers() {
        return appUserRepository.findAll();
    }

    public AppUser validateAppUser(String email, String password) {
        List<AppUser> appUsers = getAppUsers();

        for(AppUser appUser : appUsers) {
            if(appUser.getEmail().equals(email) && appUser.getPassword().equals(password)) {
                return appUser;
            }
        }

        return null;
    }

    @Transactional
    public RegisterStatus registerAppUser(String username, String email, String password) {
        RegisterStatus registerStatus = new RegisterStatus();

        // Check username
        if(AppUserValidator.isValidUsername(username)) {
            Optional<AppUser> appUserOptional = appUserRepository.findAppUserByUsername(username);

            if(appUserOptional.isPresent()) {
                registerStatus.setResUsernameExistError(true);
            }
        } else {
            registerStatus.setResUsernameError(true);
        }

        // Check email
        if(AppUserValidator.isValidEmail(email)) {
            Optional<AppUser> appUserOptional = appUserRepository.findAppUserByEmail(email);

            if(appUserOptional.isPresent()) {
                registerStatus.setResEmailExistError(true);
            }
        } else {
            registerStatus.setResEmailError(true);
        }

        // Check password
        if(!AppUserValidator.isValidPassword(password)) {
            registerStatus.setResPasswordError(true);
        }

        // Register new appUser if all requirements are met
        if(registerStatus.isRegisterSuccess()) {
            AppUser appUser = new AppUser(email, password, username, "noname", LocalDate.of(2000, 1, 1), false, 0, "USER");
            appUserRepository.save(appUser);
        }

        return registerStatus;
    }
}
