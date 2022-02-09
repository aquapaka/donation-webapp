package com.aquapaka.donationwebapp.service;

import java.util.List;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.repository.AppUserRepository;

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
}
