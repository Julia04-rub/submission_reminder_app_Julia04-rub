#!/bin/bash

# Prevent script from running multiple times simultaneously
if pgrep -f "$(basename "$0")" > /dev/null; then
    echo "⚠️ Script is already running. Exiting..."
    exit 1
fi
# Ask the user for their name
read -p "Enter your name: " userName
# Define main directory
mainDir="submission_reminder_${userName}"

# Create main directory
mkdir -p "$mainDir/scripts" "$mainDir/config" "$mainDir/data"
# Create required files
touch "$mainDir/scripts/reminder.sh"
touch "$mainDir/scripts/functions.sh"
touch "$mainDir/scripts/startup.sh"
touch "$mainDir/config/config.env"
touch "$mainDir/data/submissions.txt"
# Populate config.env
cat <<EOL > "$mainDir/config/config.env"
# Configuration file for Submission Reminder App
APP_NAME="Submission Reminder App"
NOTIFICATION_INTERVAL="10m"
EOL
# Populate reminder.sh
cat <<EOL > "$mainDir/scripts/reminder.sh"
#!/bin/bash
source "\$(dirname "\$0")/functions.sh"
echo "Running reminder script..."
notify_users
EOL
chmod +x "$mainDir/scripts/reminder.sh"  # Make it executable
# Populate functions.sh
cat <<EOL > "$mainDir/scripts/functions.sh"
#!/bin/bash
function notify_users() {
  echo "Sending reminder notifications..."
}
EOL
chmod +x "$mainDir/scripts/functions.sh"  # Make it executable
# Populate submissions.txt with sample data
cat <<EOL > "$mainDir/data/submissions.txt"
# Student Submission Records
mukire serge, 2025-02-20
ganza fidel, 2025-02-21
keza gentille, 2025-02-22
charmante rubibi, 2025-02-23
tonny bleir, 2025-02-24
Mikah jai, 2025-02-25
Millan jessy, 2025-02-26
Morgan jessy, 2025-02-27
skyla zerah, 2025-02-28
EOL
# Implement startup.sh
cat <<EOL > "$mainDir/scripts/startup.sh"
#!/bin/bash
echo "Starting Submission Reminder App..."
bash "\$(dirname "\$0")/reminder.sh"
EOL
chmod +x "$mainDir/scripts/startup.sh"  # Make it executable
echo "Environment setup complete!"#!/bin/bash

# Ask the user for their name
read -p "Enter your name: " userName

# Define main directory
mainDir="submission_reminder_${userName}"

# Create main directory
mkdir -p "$mainDir/scripts" "$mainDir/config" "$mainDir/data"

# Create required files
touch "$mainDir/scripts/reminder.sh"
touch "$mainDir/scripts/functions.sh"
touch "$mainDir/scripts/startup.sh"
touch "$mainDir/config/config.env"
touch "$mainDir/data/submissions.txt"

# Populate config.env
cat <<EOL > "$mainDir/config/config.env"
# Configuration file for Submission Reminder App
APP_NAME="Submission Reminder App"
NOTIFICATION_INTERVAL="10m"
EOL

# Populate reminder.sh
cat <<EOL > "$mainDir/scripts/reminder.sh"
#!/bin/bash
source "\$(dirname "\$0")/functions.sh"
echo "Running reminder script..."
notify_users
EOL
chmod +x "$mainDir/scripts/reminder.sh"

# Populate functions.sh
cat <<EOL > "$mainDir/scripts/functions.sh"
#!/bin/bash
function notify_users() {
  echo "Sending reminder notifications..."
}
EOL
chmod +x "$mainDir/scripts/functions.sh"

# Populate submissions.txt with sample data
cat <<EOL > "$mainDir/data/submissions.txt"
# Student Submission Records
mukire serge, 2025-02-20
ganza fidel, 2025-02-21
keza gentille, 2025-02-22
charmante rubibi, 2025-02-23
tonny bleir, 2025-02-24
Mikah jai, 2025-02-25
Millan jessy, 2025-02-26
Morgan jessy, 2025-02-27
skyla zerah, 2025-02-28
EOL

# Implement startup.sh
cat <<EOL > "$mainDir/scripts/startup.sh"
#!/bin/bash
echo "Starting Submission Reminder App..."
bash "\$(dirname "\$0")/reminder.sh"
EOL
chmod +x "$mainDir/scripts/startup.sh"

echo "Environment setup complete!"
