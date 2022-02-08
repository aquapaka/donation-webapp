package com.aquapaka.donationwebapp.repository;

import com.aquapaka.donationwebapp.model.Donation;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonationRepository extends JpaRepository<Donation, Long>{
    
}
