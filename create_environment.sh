#!/bin/bash

# Prompt user for their name
echo -n "Enter your name: "
read user_name

# Set up the base directory with the user's name
base_dir="submission_reminder_${user_name}"

# Create necessary directories
mkdir -p "$base_dir/app" "$base_dir/config" "$base_dir/modules" "$base_dir/assets"

# Create necessary files
touch "$base_dir/config/config.env"
touch "$base_dir/app/reminder.sh"
chmod u+x "$base_dir/app/reminder.sh"

touch "$base_dir/modules/functions.sh"
chmod u+x "$base_dir/modules/functions.sh"

touch "$base_dir/startup.sh"
chmod u+x "$base_dir/startup.sh"

touch "$base_dir/assets/submissions.txt"

# Populate the submissions file
echo 'student, assignment, submission status
here, Shell Navigation, submitted
Aaliyah, Shell Navigation, not submitted
Ange, Shell Navigation, not submitted
kean, Shell Navigation, not submitted
kezia, Shell Navigation, submitted
rein, Shell Navigation, not submitted
rinnah, Shell Navigation, submitted' > "$base_dir/assets/submissions.txt"

# Populate the config file
echo '# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2' > "$base_dir/config/config.env"

# Populate the functions.sh file
echo '#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)
        # Check if assignment matches and status is "not submitted"
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}' > "$base_dir/modules/functions.sh"

# Populate the reminder.sh file
echo '#!/bin/bash

# Source environment variables and helper functions
source "$(dirname "$0")/../config/config.env"
source "$(dirname "$0")/../modules/functions.sh"

# Path to the submissions file
submissions_file="$(dirname "$0")/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"' > "$base_dir/app/reminder.sh"

# Populate the startup.sh file
echo '#!/bin/bash
bash "$(dirname "$0")/app/reminder.sh"' > "$base_dir/startup.sh"

