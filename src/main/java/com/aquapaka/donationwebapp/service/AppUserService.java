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
}
