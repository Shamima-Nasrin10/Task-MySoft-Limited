import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {SettingsComponent} from "./settings/settings.component";
import {DashboardComponent} from "./dashboard/dashboard.component";
import {PatientRegisterComponent} from "./patient/patient-register/patient-register.component";
import {PatientViewComponent} from "./patient/patient-view/patient-view.component";


const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  { path: 'dashboard', component: DashboardComponent },
  {path: 'patient-register', component: PatientRegisterComponent },
  {path: 'patient-edit/:id', component: PatientRegisterComponent },
  {path: 'patient-view', component: PatientViewComponent },
  { path: 'settings', component: SettingsComponent },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {

}
