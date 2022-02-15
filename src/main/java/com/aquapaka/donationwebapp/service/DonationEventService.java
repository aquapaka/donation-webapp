package com.aquapaka.donationwebapp.service;

import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.model.status.ValidateDonationEventStatus;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

@Service
public class DonationEventService {

    @Autowired
    private DonationEventRepository donationEventRepository;
    @Autowired
    private DonationRepository donationRepository;

    public List<DonationEvent> getDonationEvents() {
        List<DonationEvent> donationEvents = donationEventRepository.findAll();

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEvents) {
            donationEvent.setTotalDonation(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEvents) {
            long currentDonationAmount = donationRepository.sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }
        
        // Sort event list by progress percent
        donationEvents.sort(new Comparator<DonationEvent>() {
            @Override
            public int compare(DonationEvent d1, DonationEvent d2) {
                if(d1.getProgressPercent() < d2.getProgressPercent()) {
                    return -1;
                } else {
                    return 1;
                }
            }
        });

        return donationEvents;
    }

    public List<DonationEvent> getDonationEventsSearchBy(String searchText, String searchType) {
        List<DonationEvent> allDonationEvents = donationEventRepository.findAll();
        List<DonationEvent> donationEvents = new ArrayList<>();

        if(searchType.equals("title")) {
            for (DonationEvent donationEvent : allDonationEvents) {
                String title = Normalizer.normalize(donationEvent.getTitle().trim().toLowerCase(), Form.NFD); 
                searchText = Normalizer.normalize(searchText.trim().toLowerCase(), Form.NFD);

                if(title.contains(searchText)) {
                    donationEvents.add(donationEvent);
                }
            }
            System.out.println("----------------------");
        } else if (searchType.equals("id")) {
            for (DonationEvent donationEvent : allDonationEvents) {
                if(String.valueOf(donationEvent.getDonationEventId()).contains(searchText.trim())) {
                    donationEvents.add(donationEvent);
                }
            }
        } else {
            System.out.println("Search Type not valid!");
            throw new IllegalStateException("Search Type not valid!");
        }

        // Count total donation for each event
        for (DonationEvent donationEvent : donationEvents) {
            donationEvent.setTotalDonation(donationRepository.countByDonationEvent(donationEvent));
        }

        // Count current donation amount for each event
        for (DonationEvent donationEvent : donationEvents) {
            long currentDonationAmount = donationRepository.sumDonationAmountByDonationEventId(donationEvent.getDonationEventId());
            donationEvent.setCurrentDonationAmount(currentDonationAmount);
        }
        
        // Sort event list by progress percent
        donationEvents.sort(new Comparator<DonationEvent>() {
            @Override
            public int compare(DonationEvent d1, DonationEvent d2) {
                if(d1.getProgressPercent() < d2.getProgressPercent()) {
                    return -1;
                } else {
                    return 1;
                }
            }
        });

        return donationEvents;
    }

    public Optional<DonationEvent> getDonationEventById(long id) {
        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);

        if(donationEventOptional.isPresent()) {
            donationEventOptional.get().setTotalDonation(donationRepository.countByDonationEvent(donationEventOptional.get()));
        }

        return donationEventOptional;
    }

    public boolean deleteDonationEventById(long id) {
        if(donationEventRepository.findById(id).isPresent()) {
            donationEventRepository.deleteById(id);
            return true;
        } else {
            return false;
        }
    }

    @Transactional
    public boolean deleteDonationEventsByIds(List<Long> ids) {

        for(long id : ids) {
            if(donationEventRepository.findById(id).isPresent()) {
                donationEventRepository.deleteById(id);
            } else {
                throw new DataIntegrityViolationException("Throwing exception for Rollback!!!");
            }
        }

        return true;
    }

    public ValidateDonationEventStatus updateDonationEventInfoById(long id, String title, String detail, String image, String total, String endTimeString) {
        // Get donation event
        Optional<DonationEvent> donationEventOptional = donationEventRepository.findById(id);
        if(!donationEventOptional.isPresent()) return null;
        DonationEvent donationEvent = donationEventOptional.get();

        // Validate all fields
        ValidateDonationEventStatus status = new ValidateDonationEventStatus();

        if(title.trim().isEmpty()) status.setTitleEmpty(true);
        if(detail.trim().isEmpty()) status.setDetailEmpty(true);
        if(image.trim().isEmpty()) status.setImageEmpty(true);
        long totalAmount = 0;
        if(total.trim().isEmpty()) {
            status.setTotalDonationAmountEmpty(true);
        } else {
            try {
                totalAmount = Long.parseLong(total);
            } catch (Exception e) {
                status.setTotalDonationAmountError(true);
            }
        }
        if(totalAmount <= 0) status.setTotalDonationAmountError(true);
        // Convert date string into localdate object
        LocalDate endTime = LocalDate.now();
        try {
            String[] endTimeList = endTimeString.split("-");
            endTime = LocalDate.of(Integer.parseInt(endTimeList[0]), Integer.parseInt(endTimeList[1]), Integer.parseInt(endTimeList[2]));
            if(!endTime.isAfter(donationEvent.getStartTime())) status.setEndDateSmallerThanStartDate(true);
        } catch (Exception e) {
            status.setDateNotValid(true);
        }

        if(!status.isValidDonationEvent()) return status;

        // Update donation event info
        donationEvent.setTitle(title);
        donationEvent.setDetail(detail);
        donationEvent.setImages(image);
        donationEvent.setTotalDonationAmount(totalAmount);
        donationEvent.setEndTime(endTime);

        // Save donation event
        donationEventRepository.save(donationEvent);

        return status;
    }

    public ValidateDonationEventStatus addDonationEvent(String title, String detail, String image, String total, String startTimeString, String endTimeString) {

        // Validate all fields
        ValidateDonationEventStatus status = new ValidateDonationEventStatus();

        if(title.trim().isEmpty()) status.setTitleEmpty(true);
        if(detail.trim().isEmpty()) status.setDetailEmpty(true);
        if(image.trim().isEmpty()) status.setImageEmpty(true);
        long totalAmount = 0;
        if(total.trim().isEmpty()) {
            status.setTotalDonationAmountEmpty(true);
        } else {
            try {
                totalAmount = Long.parseLong(total);
            } catch (Exception e) {
                status.setTotalDonationAmountError(true);
            }
        }
        if(totalAmount <= 0) status.setTotalDonationAmountError(true);
        LocalDate startTime = LocalDate.now();
        LocalDate endTime = LocalDate.now();
        try {
            // Parse time string into localDate
            String[] timeList = startTimeString.split("-");
            startTime = LocalDate.of(Integer.parseInt(timeList[0]), Integer.parseInt(timeList[1]), Integer.parseInt(timeList[2]));
            timeList = endTimeString.split("-");
            endTime = LocalDate.of(Integer.parseInt(timeList[0]), Integer.parseInt(timeList[1]), Integer.parseInt(timeList[2]));
            if(!endTime.isAfter(startTime)) status.setEndDateSmallerThanStartDate(true);
        } catch (Exception e) {
            status.setDateNotValid(true);
        }
        // Return without add if there is an error
        if(!status.isValidDonationEvent()) return status;

        // Create donation event
        DonationEvent donationEvent = new DonationEvent(title, detail, image, totalAmount, startTime, endTime);

        // Save donation event into database
        donationEventRepository.save(donationEvent);

        return status;
    }
}
