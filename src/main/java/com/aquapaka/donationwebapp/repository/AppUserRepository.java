package com.aquapaka.donationwebapp.repository;

import com.aquapaka.donationwebapp.model.AppUser;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    
}
