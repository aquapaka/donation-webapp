package com.aquapaka.donationwebapp.repository;

import com.aquapaka.donationwebapp.model.AppUser;
import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DonationRepository extends JpaRepository<Donation, Long>{
    int countByDonationEvent(DonationEvent donationEvent);

    @Query(value = "SELECT ISNULL(SUM(d.donation_amount), 0) FROM donation d WHERE d.donation_event_id = :donationEventId", nativeQuery = true)
    long sumDonationAmountByDonationEventId(@Param("donationEventId") Long donationEventId);

    Page<Donation> findAllByDonationEventTitleContainsIgnoreCase(String title, Pageable pageable);
    Page<Donation> findAllByDonationEventDonationEventId(Long donationEventId, Pageable pageable);
    Page<Donation> findAllByAppUserUsernameContainsIgnoreCase(String username, Pageable pageable);
    Page<Donation> findAllByAppUserAppUserId(Long appUserId, Pageable pageable);

    Page<Donation> findAllByDonationEventTitleContainsIgnoreCaseAndAppUser(String title, AppUser appUser, Pageable pageable);
    Page<Donation> findAllByDonationEventDonationEventIdAndAppUser(Long donationEventId, AppUser appUser, Pageable pageable);
}
