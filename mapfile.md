Project Map and Concept
-----------------------
Patients log in and can keep track of the medications they take.

Models -

User
has_many medications
- username*
- email*
- password digest*

Medication
belongs_to user
- name*
- nickname
- condition*
- prescribing physician
- date prescribed
- date added to site
- dosage*
- dosage units (mg, mcg, ml, etc)*
- frequency*

* required fields


To do:

- required field validation for medications
- methods for validating that med exists, user is logged in, and med belongs to user to avoid duplicate code
- permanent navbar
- User instance method to return array of all user's meds to avoid duplicate code - DONE
- Normalize inputs when comparing (i.e. to lowercase) - DONE
