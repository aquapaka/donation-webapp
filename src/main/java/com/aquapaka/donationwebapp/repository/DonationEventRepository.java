package com.aquapaka.donationwebapp.repository;

import com.aquapaka.donationwebapp.model.DonationEvent;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonationEventRepository extends JpaRepository<DonationEvent, Long>{
}
