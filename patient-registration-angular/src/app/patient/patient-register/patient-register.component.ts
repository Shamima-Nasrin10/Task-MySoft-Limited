import {Component, OnInit} from '@angular/core';
import {Gender, Patient} from "../patient.model";
import {PatientService} from "../patient.service";
import {ActivatedRoute, Router} from "@angular/router";

import {AlertUtil} from "../../util/alert.util";

@Component({
  selector: 'app-patient-register',
  templateUrl: './patient-register.component.html',
  styleUrl: './patient-register.component.css'
})
export class PatientRegisterComponent implements OnInit{

  patient: Patient = new Patient();
  imageFile?: File;
  gender = ['MALE', 'FEMALE', 'OTHERS'];

  patientId?: number;

  constructor(
    private patientService: PatientService,
    private route: ActivatedRoute,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.patientId = this.route.snapshot.params['id'];
    if (this.patientId) {
      this.loadPatient(this.patientId);
    }
  }


  private loadPatient(id: number) {
    this.patientService.findPatientsById(id).subscribe({
      next: apiResponse => {
        if (apiResponse && apiResponse.successful) {
          this.patient = apiResponse.data['patient'];
        } else {
          AlertUtil.error(apiResponse);
        }
      },
      error: error => {
        AlertUtil.error(error);
      }
    });
  }

  onImagePicked(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      this.imageFile = input.files[0];
    }
  }

  onSubmit() {
    const patientObservable = this.patientId
      ? this.patientService.updatePatient(this.patient, this.imageFile)
      : this.patientService.savePatient(this.patient, this.imageFile);

    patientObservable.subscribe({
      next: apiResponse => {
        if (apiResponse && apiResponse.successful) {
          AlertUtil.success(apiResponse);
          this.router.navigate(['/patient-view']);
        } else {
          AlertUtil.error(apiResponse);
        }
      },
      error: error => {
        AlertUtil.error(error);
      }
    });
  }

  onDobChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.value) {
      const dob = new Date(input.value);
      const age = this.calculateAge(dob);
      this.patient.age = age;
    }
  }

  private calculateAge(dob: Date): number {
    const today = new Date();
    let age = today.getFullYear() - dob.getFullYear();
    const m = today.getMonth() - dob.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < dob.getDate())) {
      age--;
    }
    return age;
  }


  onImageChange(event: any) {
    this.imageFile = event.target.files[0];
  }

}
