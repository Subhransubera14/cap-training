namespace hospital.management;

type Name        : String(100);
type Phone       : String(15);
type Email       : String(100);
type Amount      : Decimal(10,2);
type MedicalNote : String(500);

type Gender : String enum {
    Male;
    Female;
    Other;
}

type BloodGroup : String enum {
    A_Pos;
    A_Neg;
    B_Pos;
    B_Neg;
    O_Pos;
    O_Neg;
    AB_Pos;
    AB_Neg;
}

type AppointmentStatus : String enum {
    Scheduled;
    Completed;
    Cancelled;
    NoShow;
}

entity Departments {
    key ID      : UUID;
    name        : Name;
    floor       : Integer;
    head        : String(100);
    capacity    : Integer;
    phone       : Phone;
    isActive    : Boolean default true;
    doctors     : Composition of many Doctors
                  on doctors.department = $self;
}

entity Doctors {
    key ID            : UUID;
    firstName         : String(50);
    lastName          : String(50);
    specialization    : String(100);
    qualification     : String(100);
    experience        : Integer;
    fee               : Amount;
    department        : Association to Departments;
    phone             : Phone;
    email             : Email;
    availableDays     : String(50);
    isActive          : Boolean default true;
}

entity Patients {
    key ID               : UUID;
    firstName            : String(50);
    lastName             : String(50);
    dateOfBirth          : Date;
    gender               : Gender;
    bloodGroup           : BloodGroup;
    phone                : Phone;
    email                : Email;
    address              : String(200);
    emergencyContact     : Phone;
    registrationDate     : Date;
}

entity Appointments {
    key ID               : UUID;
    patient              : Association to Patients;
    doctor               : Association to Doctors;
    appointmentDate      : Date;
    appointmentTime      : Time;
    status               : AppointmentStatus default 'Scheduled';
    reason               : String(200);
    notes                : MedicalNote;
    fee                  : Amount;
}

entity MedicalRecords {
    key ID               : UUID;
    patient              : Association to Patients;
    doctor               : Association to Doctors;
    appointment          : Association to Appointments;
    diagnosis            : MedicalNote;
    prescription         : MedicalNote;
    testRecommended      : MedicalNote;
    recordDate           : Date;
}