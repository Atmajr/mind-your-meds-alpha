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

- make flash messages more visible
- required field validation for medications - DONE
- permanent navbar - DONE
- User instance method to return array of all user's meds to avoid duplicate code - DONE
- Normalize inputs when comparing (i.e. to lowercase) - DONE

Version 0.2:

- helper methods for validating that med exists, user is logged in, and med belongs to user to avoid duplicate code
- move flash messages to layout.erb
