package com.aquapaka.donationwebapp.controller;

import java.security.NoSuchAlgorithmException;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.Gender;
import com.aquapaka.donationwebapp.model.state.Role;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.service.FilterService;
import com.aquapaka.donationwebapp.util.PasswordEncrypt;
import com.aquapaka.donationwebapp.validator.status.AddAppUserStatus;
import com.aquapaka.donationwebapp.validator.status.ChangePasswordStatus;
import com.aquapaka.donationwebapp.validator.status.ValidateAppUserStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/AppUser")
public class AppUserController {
    
    @Autowired
    private AppUserService appUserService;
    
    @Autowired
    private FilterService filterService;

    @GetMapping("/{id}")
    public @ResponseBody AppUser getAppUser(@PathVariable long id, HttpServletRequest request) {

        if(!filterService.canAccessUserData(request, id)) throw new IllegalStateException("Can't access this data!");

        return appUserService.getAppUserById(id);
    }

    @PostMapping
    public @ResponseBody AddAppUserStatus addAppUser(
    @RequestParam String username,
    @RequestParam String email,
    @RequestParam String fullname,
    @RequestParam String dateOfBirth,
    @RequestParam String gender,
    @RequestParam String phoneNumber,
    @RequestParam String role,
    HttpServletRequest request) {
        if(!filterService.canAccessAdminData(request)) throw new IllegalStateException("Can't access this data!");

        Role userRole;
        if (role.equals(Role.USER.name())) {
            userRole = Role.USER;
        } else if (role.equals(Role.ADMIN.name())) {
            userRole = Role.ADMIN;
        } else {
            throw new IllegalStateException("User role not valid!");
        }

        Gender userGender;
        if (gender.equals(Gender.NOT_SET.name())) {
            userGender = Gender.NOT_SET;
        } else if (gender.equals(Gender.MALE.name())) {
            userGender = Gender.MALE;
        } else if (gender.equals(Gender.FEMALE.name())) {
            userGender = Gender.FEMALE;
        } else {
            throw new IllegalStateException("Gender not valid!");
        }

        return appUserService.addAppUser(username, email, fullname, dateOfBirth, userGender, phoneNumber, userRole);
    }

    @PutMapping("/{id}")
    public @ResponseBody ValidateAppUserStatus updateAppUser(@PathVariable long id,
    @RequestParam String fullname,
    @RequestParam String dateOfBirth,
    @RequestParam String gender,
    @RequestParam String phoneNumber,
    @RequestParam String role,
    HttpServletRequest request) {

        if(!filterService.canAccessUserData(request, id)) throw new IllegalStateException("Can't access this data!");

        Role userRole;
        if (role.equals(Role.USER.name())) {
            userRole = Role.USER;
        } else if (role.equals(Role.ADMIN.name())) {
            userRole = Role.ADMIN;
        } else {
            throw new IllegalStateException("Event state not valid!");
        }

        Gender userGender;
        if (gender.equals(Gender.NOT_SET.name())) {
            userGender = Gender.NOT_SET;
        } else if (gender.equals(Gender.MALE.name())) {
            userGender = Gender.MALE;
        } else if (gender.equals(Gender.FEMALE.name())) {
            userGender = Gender.FEMALE;
        } else {
            throw new IllegalStateException("Gender not valid!");
        }

        return appUserService.updateAppUserInfoById(id, fullname, dateOfBirth, userGender, phoneNumber, userRole);
    }

    
    @PutMapping("/resetPassword")
    public @ResponseBody boolean resetAppUserPassword(HttpServletRequest request, @RequestParam String email) {
        
        return appUserService.resetAppUserPassword(email);
    }

    @PutMapping("/changePassword")
    public @ResponseBody ChangePasswordStatus changeAppUserPassword(
    @RequestParam String oldPassword,
    @RequestParam String newPassword,
    HttpServletRequest request) {

        // Get account data from session
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        String encryptedNewPassword;
        try {
            encryptedNewPassword = PasswordEncrypt.encryptPassword(newPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(e);
        }

        ChangePasswordStatus status = appUserService.changeAppUserPassword(email, oldPassword, newPassword);

        if(status.isChangePasswordSuccess()) {
            session.setAttribute("password", encryptedNewPassword);
        }
        
        return status;
    }

    @DeleteMapping("/{id}")
    public @ResponseBody boolean deleteAppUser(@PathVariable long id, HttpServletRequest request) {
    
        if (!filterService.canAccessUserData(request, id)) throw new IllegalStateException("Can't access this data!");
    
        return appUserService.deleteAppUserById(id);
    }
}
