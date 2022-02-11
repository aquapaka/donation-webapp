package com.aquapaka.donationwebapp.repository;

import com.aquapaka.donationwebapp.model.Donation;
import com.aquapaka.donationwebapp.model.DonationEvent;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DonationRepository extends JpaRepository<Donation, Long>{
    int countByDonationEvent(DonationEvent donationEvent);

    @Query(value = "SELECT ISNULL(SUM(d.donation_amount), 0) FROM donation d WHERE d.donation_event_id = :donationEventId", nativeQuery = true)
    long sumDonationAmountByDonationEventId(@Param("donationEventId") Long donationEventId);
}
