package com.aquapaka.donationwebapp.service;

import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.AppUserState;
import com.aquapaka.donationwebapp.model.state.Gender;
import com.aquapaka.donationwebapp.model.state.Role;
import com.aquapaka.donationwebapp.repository.AppUserRepository;
import com.aquapaka.donationwebapp.util.PasswordEncrypt;
import com.aquapaka.donationwebapp.validator.AppUserValidator;
import com.aquapaka.donationwebapp.validator.status.RegisterStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppUserService {
    
    @Autowired
    private AppUserRepository appUserRepository;

    public List<AppUser> getAppUsers() {
        return appUserRepository.findAll();
    }

    public Optional<AppUser> getAppUserById(long id) {
        
        return appUserRepository.findById(id);
    }

    public AppUser validateLogin(String email, String password) {
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
        RegisterStatus registerStatus = AppUserValidator.validateRegister(username, email, password);

        // Register new appUser if all requirements are met
        if(registerStatus.isRegisterSuccess()) {

            // Encrypt password
            String encryptedPassword;
            try {
                encryptedPassword = PasswordEncrypt.toHexString(PasswordEncrypt.getSHA(password));
            } catch (NoSuchAlgorithmException e) {
                throw new IllegalStateException(e);
            }
            
            AppUser appUser = new AppUser(email, encryptedPassword, username, "noname", LocalDate.of(2000, 1, 1), Gender.NOT_SET, "Not set", Role.USER, AppUserState.INACTIVE, 0);
            appUserRepository.save(appUser);
        }

        return registerStatus;
    }

    public void deleteAppUserById(long id) {
        appUserRepository.deleteById(id);
    }

    public void updateAppUserInfoById(long id, String fullname, String dateOfBirth, String gender, String phoneNumber, Role role) {
        // Get app user
        Optional<AppUser> appUserOptional = appUserRepository.findById(id);
        if(!appUserOptional.isPresent()) throw new IllegalStateException("Update app user id not found!");

        AppUser appUser = appUserOptional.get();

        // Update app user info
        appUser.setFullname(fullname);
        String[] dateOfBirthList = dateOfBirth.split("-");
        LocalDate dob = LocalDate.of(Integer.parseInt(dateOfBirthList[0]), Integer.parseInt(dateOfBirthList[1]), Integer.parseInt(dateOfBirthList[2]));
        appUser.setDateOfBirth(dob);
        appUser.setGender(null);
        appUser.setPhoneNumber(phoneNumber);
        appUser.setRole(role);

        // Save app user
        appUserRepository.save(appUser);
    }

    public void updateAppUserCodeById(long id, int code) {
        // Get app user
        AppUser appUser = appUserRepository.getById(id);

        appUser.setActiveCode(code);

        appUserRepository.save(appUser);
    }

    public boolean validateActiveCode(long id, int code) {
        // Get app user
        AppUser appUser = appUserRepository.getById(id);

        if(appUser.getActiveCode() == code) {
            appUser.setState(AppUserState.ACTIVE);
            appUserRepository.save(appUser);
            return true;
        } else {
            return false;
        }
    }
}
