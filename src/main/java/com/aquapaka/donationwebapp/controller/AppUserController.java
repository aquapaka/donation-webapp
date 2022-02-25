package com.aquapaka.donationwebapp.controller;

import java.util.Optional;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.state.Gender;
import com.aquapaka.donationwebapp.model.state.Role;
import com.aquapaka.donationwebapp.service.AppUserService;
import com.aquapaka.donationwebapp.validator.status.ValidateAppUserStatus;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/AppUser")
public class AppUserController {
    
    @Autowired
    private AppUserService appUserService;

    @GetMapping("/{id}")
    public @ResponseBody AppUser getAppUser(@PathVariable long id) {
        Optional<AppUser> appUserOptional = appUserService.getAppUserById(id);

        if(!appUserOptional.isPresent()) throw new IllegalStateException("AppUser id not found!");

        return appUserOptional.get();
    }

    @PutMapping("/{id}")
    public @ResponseBody ValidateAppUserStatus updateAppUser(@PathVariable long id,
    @RequestParam String fullname,
    @RequestParam String dateOfBirth,
    @RequestParam String gender,
    @RequestParam String phoneNumber,
    @RequestParam String role) {

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

    @DeleteMapping("/{id}")
    public @ResponseBody boolean deleteAppUser(@PathVariable long id) {

        return appUserService.deleteAppUserById(id);
    }

}
