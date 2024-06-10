# README

## This is test application

### Deployed at

https://vhospital-cod.herokuapp.com/

### Stack & Features

| Name             | Technologies                                                                                           |
|------------------|--------------------------------------------------------------------------------------------------------|
| Backend          | Ruby 3.2.4<br/>Rails 7.1                                                                               |
| Frontend         | CSS, SCSS<br/>HTML, ERB<br/>Bootstrap                                                                  |
| Database         | PostgreSQL                                                                                             |
| Server           | Puma                                                                                                   |
| Testing Tools    | RSpec<br/>Shoulda Matchers<br/>FactoryBot<br/>Faker                                                    |
| Linters          | Rubocop                                                                                                |
| Authorization    | Cancancan                                                                                              |
| Authentication   | Devise                                                                                                 |

### Credentials

| User type       | Login                                       | Password          |
|-----------------|---------------------------------------------|-------------------|
| Admin           | 1234567890                                  | test123           |
|                 |                                             |                   |
| Patients        | See list of patients<br/>when login as admin| 123456<br/>for all|
|                 |                                             |                   |
| Doctors         | See list of doctors<br/>when login as admin | 123456<br/>for all|


### Task description

To create application to manage hospital

Users' types:
- patient (User)
- doctor (Doctor)
- admin (Admin)

Each type of users should have such functionality:

1. Patient can register and login to it account. Can see doctoctors' list by categories,
can make assignment with any doctor, and can recieve recommendations from doctor.
2. Doctor can login to it account. Can see list of assignments, write an answer to patient.
Doctor is assigned to one of the categiries.
3. Admin has access to lists of patients and doctros. Can create category and assign (reassign) doctors to categories.

Authentication and authorization requirements:
- use gem devise for authentication;
- use gem cancancan for authorization
- all users can login using their phone number and password;


Categories requirements:
- validation by uniq name;
- can by assigned to several doctors;

Assignments requirements:
- doctor can have only 10 open (not answered) assignments at a time;
- patient can hane only 1 (not answered) assignment with the same doctor;
- assignment is closed (ad stred, not deleted) when doctor write an answe to patent;

