package com.aquapaka.donationwebapp.service;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import com.aquapaka.donationwebapp.model.DonationEvent;
import com.aquapaka.donationwebapp.repository.DonationEventRepository;
import com.aquapaka.donationwebapp.repository.DonationRepository;

import org.springframework.beans.factory.annotation.Autowired;
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

    public Optional<DonationEvent> getDonationEventById(long id) {
        Optional<DonationEvent> donationEvent = donationEventRepository.findById(id);
        donationEvent.get().setTotalDonation(donationRepository.countByDonationEvent(donationEvent.get()));
        return donationEvent;
    }

    public void deleteDonationEventById(long id) {
        donationEventRepository.deleteById(id);
    }

    public void updateDonationEventInfoById(long id, String title, String detail, String image, long total, String endTime) {
        // Get donation event
        DonationEvent donationEvent = donationEventRepository.getById(id);

        // Update donation event info
        donationEvent.setTitle(title);
        donationEvent.setDetail(detail);
        donationEvent.setImages(image);
        donationEvent.setTotalDonationAmount(total);
        String[] endTimeList = endTime.split("-");
        LocalDate endTimeParsed = LocalDate.of(Integer.parseInt(endTimeList[0]), Integer.parseInt(endTimeList[1]), Integer.parseInt(endTimeList[2]));
        donationEvent.setEndTime(endTimeParsed);

        // Save donation event
        donationEventRepository.save(donationEvent);
    }

    public void addDonationEvent(String title, String detail, String image, long total, String startTime, String endTime) {
        // Parse time string into localDate
        String[] timeList = startTime.split("-");
        LocalDate startTimeParsed = LocalDate.of(Integer.parseInt(timeList[0]), Integer.parseInt(timeList[1]), Integer.parseInt(timeList[2]));
        timeList = endTime.split("-");
        LocalDate endTimeParsed = LocalDate.of(Integer.parseInt(timeList[0]), Integer.parseInt(timeList[1]), Integer.parseInt(timeList[2]));

        // Create donation event
        DonationEvent donationEvent = new DonationEvent(title, detail, image, total, startTimeParsed, endTimeParsed);

        // Save donation event
        donationEventRepository.save(donationEvent);
    }
}
