#!/bin/bash

# Prompt user to enter disk device
echo "Enter the disk device to be reviewed (e.g. /dev/sda1):"
read DISK

# Run fsck to scan the disk for issues
echo "Scanning disk $DISK for issues..."
fsck -p $DISK

# Check the exit status of fsck
if [ $? -eq 0 ]; then
  echo "Disk $DISK is clean."
else
  echo "Disk $DISK has issues."
  
  # Prompt user to repair disk
  echo "Do you want to attempt to repair the disk? (y/n)"
  read REPAIR

  if [ "$REPAIR" = "y" ]; then
    # Run fsck with automatic repair
    echo "Repairing disk $DISK..."
    fsck -y $DISK
    
    # Check the exit status of fsck
    if [ $? -eq 0 ]; then
      echo "Disk $DISK has been repaired."
    else
      echo "Disk $DISK has issues that could not be repaired automatically."
    fi
  else
    echo "No repair attempted. Exiting..."
  fi
fi
