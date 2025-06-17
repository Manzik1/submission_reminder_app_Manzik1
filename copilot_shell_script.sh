#!/bin/bash

# Directory and file paths
ROOT_DIR="submission_reminder_Manzik1"
SUBMISSIONS_FILE="$ROOT_DIR/assets/submissions.txt"
CFG_FILE="$ROOT_DIR/config/config.env"

# Prompt user input
echo "Enter the assignment name:"
read ASSIGNMENT_NAME

echo "Enter the student name to check:"
read STUDENT_NAME

# Check if student has not submitted the assignment
if grep -q "$STUDENT_NAME" "$SUBMISSIONS_FILE"; then
    if grep -q "$STUDENT_NAME.*$ASSIGNMENT_NAME.*not submitted" "$SUBMISSIONS_FILE"; then
        echo "he student has NOT submitted the $ASSIGNMENT_NAME assignment."
    else
        echo "The student has either submitted or no matching 'not submitted' record for this assignment."
    fi
else
    echo "0 matching student found in the submissions file."
fi

# Update the ASSIGNMENT value in line 2 of config.env
echo "Updating assignment in config.env to \"$ASSIGNMENT_NAME\"..."
sed -i '2s|ASSIGNMENT=.*|ASSIGNMENT="'"$ASSIGNMENT_NAME"'"|' "$CFG_FILE"
echo "Assignment in config.env updated to: $ASSIGNMENT_NAME"
