package com.shamima.Patient_Registration_Backend.repository;

import com.shamima.Patient_Registration_Backend.entity.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {

}
