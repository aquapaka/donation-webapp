package com.aquapaka.donationwebapp.repository;

import com.aquapaka.donationwebapp.model.DonationEvent;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonationEventRepository extends JpaRepository<DonationEvent, Long>{
    Page<DonationEvent> findAllByTitleContainsIgnoreCase(String searchTitle, Pageable pageable);
    Page<DonationEvent> findAllByDescriptionContainsIgnoreCase(String searchDescription, Pageable pageable);
}
