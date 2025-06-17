# Assignment Submission Tracker – Manzik1

This is a streamlined bash-based monitoring application designed to track student assignment submissions and handle assignment configuration updates. Perfect for newcomers exploring shell scripting fundamentals and version control workflows.

## Project Directory Structure

```
submission_reminder_app_Manzik1/
│
├── create_environment.sh              # Script to generate project folder and files
├── copilot_shell_script.sh           # Script to check and update student assignment
├── README.md                          # This file (documentation)
│
└── submission_reminder_Manzik1/      # Created by create_environment.sh
    ├── startup.sh                     # Script to show who hasn't submitted
    ├── config/
    │   └── config.env                 # Stores the ASSIGNMENT value
    └── assets/
        └── submissions.txt           # Contains list of student submissions
```

## System Requirements

* Unix/Linux command-line environment (Ubuntu, WSL, macOS terminal, etc.)
* Git version control system installed
* Basic understanding of terminal command operations

## Implementation Instructions

### Step 1: Initialize Your Environment

Execute this command to build all required project folders and components:

```
bash create_environment.sh
```

**You'll see a folder named** `submission_reminder_Manzik1` **containing all the necessary files.**

### Step 2: Launch the Tracking System

Navigate into the created directory and execute:

```
cd submission_reminder_Manzik1
./startup.sh
```

This displays all students who have **not yet submitted** their assignments.

### Step 3: Run the Copilot Shell Script

Navigate back and execute the copilot tool for individual student verification:

```
cd ..
bash copilot_shell_script.sh
```

The script will:
1. Request you to provide:
   * Assignment name
   * Student name
2. Verify if that student has outstanding submissions
3. Modify the `ASSIGNMENT` parameter in `config/config.env`

A confirmation message appears after successfully updating the configuration.

## Repository Cleanup (for GitHub Main Branch)

Before merging into the `main` branch, clean up by removing all generated folders and files **except**:
* `create_environment.sh`
* `copilot_shell_script.sh`
* `README.md`

Execute cleanup command:

```
rm -rf submission_reminder_Manzik1
```

Then commit your changes to main branch and complete the merge process.

## Project Information

**Developer:** Manzik1  

**This system provides efficient monitoring of student assignment completion status!**
