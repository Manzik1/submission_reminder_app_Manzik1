#!/bin/bash
# Get user input for personalized directory naming
read -rp "Enter your name: " USER_NAME
ROOT_DIR="submission_reminder_${USER_NAME// /-}"

# Set up project structure with necessary folders
mkdir -p "${ROOT_DIR}"/{app,modules,assets,config}

# Generate the main reminder application
cat <<EOT > "${ROOT_DIR}/app/reminder.sh"
#!/bin/bash
# Load configuration settings and utility functions
source ./config/config.env
source ./modules/functions.sh

# Define path to student submission data
submissions_file="./assets/submissions.txt"

# Display assignment details and execute reminder check
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"
check_submissions \$submissions_file
EOT
chmod +x "${ROOT_DIR}/app/reminder.sh"

# Build the utility functions module
cat <<EOT > "${ROOT_DIR}/modules/functions.sh"
#!/bin/bash
# Utility function to parse submission data and identify non-submitters
function check_submissions {
    local submissions_file=\$1
    echo "Checking submissions in \$submissions_file"
    
    # Process each line after header row
    while IFS=, read -r student assignment status; do
        # Clean up whitespace from parsed fields
        student=\$(echo "\$student" | xargs)
        assignment=\$(echo "\$assignment" | xargs)
        status=\$(echo "\$status" | xargs)
        
        # Identify students with pending submissions for target assignment
        if [[ "\$assignment" == "\$ASSIGNMENT" && "\$status" == "not submitted" ]]; then
            echo "Reminder: \$student has not submitted the \$ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "\$submissions_file") # Exclude header line
}
EOT
chmod +x "${ROOT_DIR}/modules/functions.sh"

# Set up configuration parameters
cat <<EOT > "${ROOT_DIR}/config/config.env"
# Configuration settings for assignment tracking
ASSIGNMENT="Shell Basics"
DAYS_REMAINING=2
EOT

# Initialize sample submission data
cat <<EOT > "${ROOT_DIR}/assets/submissions.txt"
#student, assignment, submission status
Chiagoziem, Shell Basics, not submitted
Anissa, Shell Basics, not submitted
Divine, Shell Basics, submitted
David, Shell Basics, not submitted
Klaus, Shell Basics, submitted
Dickson, Shell Basics, not submitted
Samson, Shell Basics, submitted

EOT

# Build application launche
cat <<EOT > "${ROOT_DIR}/startup.sh"
#!/bin/bash
# Launch the reminder application
if [ -f "./app/reminder.sh" ]; then
    echo "Starting the reminder script..."
    bash ./app/reminder.sh
else
    echo "Reminder script not found. Exiting."
fi
EOT
chmod +x "${ROOT_DIR}/startup.sh"

# Apply executable permissions to all shell scripts
find "${ROOT_DIR}" -type f -name "*.sh" -exec chmod +x {} \;

# Installation complete
echo "completed Setup in: $ROOT_DIR"
echo "To test: cd $ROOT_DIR && ./startup.sh"
