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
