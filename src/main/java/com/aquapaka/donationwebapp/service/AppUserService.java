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
import com.aquapaka.donationwebapp.util.PasswordGenerator;
import com.aquapaka.donationwebapp.validator.AppUserValidator;
import com.aquapaka.donationwebapp.validator.status.AddAppUserStatus;
import com.aquapaka.donationwebapp.validator.status.ChangePasswordStatus;
import com.aquapaka.donationwebapp.validator.status.RegisterStatus;
import com.aquapaka.donationwebapp.validator.status.ValidateAppUserStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class AppUserService {

    private static final int USER_PER_PAGE = 8;
    
    @Autowired
    private AppUserRepository appUserRepository;

    @Autowired
    private JavaMailSender emailSender;

    public Page<AppUser> getAppUsers(int page) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");

        Pageable pageable = PageRequest.of(page, USER_PER_PAGE);

        return appUserRepository.findAll(pageable);
    }

    public Optional<AppUser> getAppUserById(long id) {
        return appUserRepository.findById(id);
    }

    public Page<AppUser> searchAppUsers(String searchText, String searchType, String sortType, int page) {
        page -= 1;
        if(page < 0) throw new IllegalStateException("Page not found!");
        
        Pageable pageable = PageRequest.of(page, USER_PER_PAGE, Sort.by(sortType));
        Page<AppUser> appUserPage;

        switch(searchType) {
            case "email":
                appUserPage = appUserRepository.findAllByEmailContainsIgnoreCase(searchText, pageable);
                break;
            case "username":
                appUserPage = appUserRepository.findAllByUsernameContainsIgnoreCase(searchText, pageable);
                break;
            case "fullname":
                appUserPage = appUserRepository.findAllByFullnameContainsIgnoreCase(searchText, pageable);
                break;
            case "phoneNumber":
                appUserPage = appUserRepository.findAllByPhoneNumberContainsIgnoreCase(searchText, pageable);
                break;
            default:
                throw new IllegalStateException("Search type not valid!");
        }

        return appUserPage;
    }

    public AppUser validateLogin(String email, String password) {
        List<AppUser> appUsers = appUserRepository.findAll();

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
                encryptedPassword = PasswordEncrypt.encryptPassword(password);
            } catch (NoSuchAlgorithmException e) {
                throw new IllegalStateException(e);
            }
            
            AppUser appUser = new AppUser(email, encryptedPassword, username, "noname", LocalDate.of(2000, 1, 1), Gender.NOT_SET, "Not set", Role.USER, AppUserState.INACTIVE, 0);
            appUserRepository.save(appUser);
        }

        return registerStatus;
    }

    @Transactional
    public AddAppUserStatus addAppUser(String username, String email, String fullname, String dateOfBirth, Gender gender, String phoneNumber, Role role) {
        AddAppUserStatus status = AppUserValidator.validateAddAppUser(username, email, fullname, dateOfBirth, phoneNumber);

        // Add new appUser if all requirements are met
        if(status.isValidAppUser()) {

            // Create new password and encrypt
            String password = PasswordGenerator.generatePassword();
            String encryptedPassword;
            try {
                encryptedPassword = PasswordEncrypt.encryptPassword(password);
            } catch (NoSuchAlgorithmException e) {
                throw new IllegalStateException(e);
            }

            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Your account has been created - DONATION");
            message.setText("Your password is " + password);

            // Send Message!
            emailSender.send(message);
            
            AppUser appUser = new AppUser(email, encryptedPassword, username, fullname, LocalDate.parse(dateOfBirth), gender, phoneNumber, role, AppUserState.INACTIVE, 0);
            appUserRepository.save(appUser);
        }

        return status;
    }

    public ValidateAppUserStatus updateAppUserInfoById(long id, String fullname, String dateOfBirth, Gender gender, String phoneNumber, Role role) {
        // Get app user
        Optional<AppUser> appUserOptional = appUserRepository.findById(id);
        if(!appUserOptional.isPresent()) throw new IllegalStateException("Update app user id not found!");

        AppUser appUser = appUserOptional.get();

        // Validate fields
        ValidateAppUserStatus status = AppUserValidator.validateAppUser(fullname, dateOfBirth, phoneNumber);

        if(!status.isValidAppUser()) {
            return status;
        }

        // Update app user info
        appUser.setFullname(fullname);
        appUser.setDateOfBirth(LocalDate.parse(dateOfBirth));
        appUser.setGender(gender);
        appUser.setPhoneNumber(phoneNumber);
        if(appUser.getRole() != Role.ADMIN) {
            appUser.setRole(role);
        }

        // Save app user
        appUserRepository.save(appUser);

        return status;
    }

    public void updateAppUserCodeById(long id, int code) {
        // Get app user
        AppUser appUser = appUserRepository.getById(id);

        appUser.setActiveCode(code);

        appUserRepository.save(appUser);
    }

    public boolean deleteAppUserById(long id) {
        Optional<AppUser> appUserOptional = appUserRepository.findById(id);
        if(appUserOptional.isPresent()) {
            if(appUserOptional.get().getRole() == Role.ADMIN) {
                return false;
            }
            appUserRepository.deleteById(id);

            return true;
        } else {
            return false;
        }
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

    public boolean resetAppUserPassword(String email) {
        Optional<AppUser> appUserOptional = appUserRepository.findAppUserByEmail(email);

        if(!appUserOptional.isPresent()) return false;

        AppUser appUser = appUserOptional.get();
        String newPassword = PasswordGenerator.generatePassword();
        String encryptedNewPassword;
        try {
            encryptedNewPassword = PasswordEncrypt.encryptPassword(newPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Reset password - DONATION");
        message.setText("Your new password is " + newPassword);

        // Send Message!
        emailSender.send(message);

        appUser.setPassword(encryptedNewPassword);
        appUserRepository.save(appUser);

        return true;
    }

    public ChangePasswordStatus changeAppUserPassword(String email, String oldPassword, String newPassword) {
        ChangePasswordStatus status = new ChangePasswordStatus();
        
        String encryptedOldPassword;
        String encryptedNewPassword;
        try {
            encryptedOldPassword = PasswordEncrypt.encryptPassword(oldPassword);
            encryptedNewPassword = PasswordEncrypt.encryptPassword(newPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }
    
        AppUser appUser = validateLogin(email, encryptedOldPassword);
        
        if (!AppUserValidator.isValidPassword(newPassword)) {
            status.setNewPasswordError(true);
        }
        if(appUser == null) {
            status.setOldPasswordError(true);
        } else {
            if (status.isChangePasswordSuccess()) {
                appUser.setPassword(encryptedNewPassword);
                appUserRepository.save(appUser);
            }
        }

        return status;
    }
}
