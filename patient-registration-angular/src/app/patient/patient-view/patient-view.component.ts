import {Component, OnInit} from '@angular/core';
import {Patient} from "../patient.model";
import {PatientService} from "../patient.service";
import {AlertUtil} from "../../util/alert.util";
import {ApiResponse} from "../../util/apiresponse.model";

@Component({
  selector: 'app-patient-view',
  templateUrl: './patient-view.component.html',
  styleUrl: './patient-view.component.css'
})
export class PatientViewComponent implements OnInit {

  patients: Patient[] = [];

  constructor(
    private patientService: PatientService
  ) { }

  ngOnInit(): void {
    this.loadPatients();
  }

  loadPatients(): void {
    this.patientService.getAllPatients().subscribe({
      next: response => {
        if (response && response.successful) {
          this.patients = response.data['patients'];
        } else {
          AlertUtil.error(response);
        }
      },
      error: error => {
        AlertUtil.error(error);
      }
    });
  }

  deletePatient(id: number): void {
    if (confirm('Are you sure you want to delete this raw material?')) {
      this.patientService.deletePatientsById(id).subscribe({
        next: (response: ApiResponse) => {
          if (response && response.successful) {
            AlertUtil.success(response);
          } else {
            AlertUtil.error(response);
          }
          this.loadPatients();
        },
        error: (error) => {
          AlertUtil.error(error);
        }
      });
    }
  }

}
