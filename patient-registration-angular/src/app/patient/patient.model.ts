export class Patient {

  id!: number;
  firstName!: string;
  lastName!: string;
  dob!: Date;
  age?: number;
  gender!: Gender;
  permanentAddress!: string;
  presentAddress!: string;
  mobileNo!: string;
  image?: string;

}
export enum Gender {
  MALE,
  FEMALE,
  OTHERS
}
