package com.aquapaka.donationwebapp.controller;

import java.util.List;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.service.AppUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "appUser")
public class AppUserController {
    
    @Autowired
    private AppUserService appUserService;

    @GetMapping
    public List<AppUser> getAppUsers() {
        return appUserService.getAppUsers();
    }
}
