# opizero-display

This repository provides Bash scripts to display system information on an I2C SSD1306 screen for the Orange Pi Zero 2W and other compatible devices.

## Features

- Displays system information on an I2C SSD1306 OLED screen.
- Configurable for different I2C oled screens (128x32, 128x64), addresses and time zones.

## Prerequisites

- Orange Pi Zero 2W or other compatible device.
- I2C SSD1306 OLED screen connected to the device.
- Linux-based operating system (e.g., Armbian or Ubuntu).

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/proun95/opizero-display.git
   cd opizero-display
   ```

2. If you cloned the repository to a directory other than the default (`/home/orangepi/opizero-display`), update the path in the scripts:
   ```bash
   sed -i 's|/home/orangepi/opizero-display|YOUR_PATH|g' *
   ```
   Replace `YOUR_PATH` with the absolute path to your directory (e.g., `/home/user/opizero-display`).

3. Turn necessary I2C on:
   ```bash
   sudo orangepi-config
   ```
   Navigate System->Hardware and turn necessary I2C on.

4. Install `i2c-tools` to detect your I2C screen:
   ```bash
   sudo apt update
   sudo apt install i2c-tools
   ```

5. Detect the I2C address of your screen:
   ```bash
   i2cdetect -y 8
   ```
   If the screen is connected to I2C bus 8, you should see `3c` in the output. If a different I2C bus is detected (e.g., bus 7), update the script:
   ```bash
   sed -i 's|8 |YOUR_NUMBER |g' update-display-info.sh
   ```
   Replace `YOUR_NUMBER` with the detected I2C bus number.

6. If your time zone differs from the default (`Europe/Samara`), update it in the script. Choose a time zone from the [List of tz database time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones):
   ```bash
   sed -i 's|Europe/Samara|YOUR_TIMEZONE|g' update-display-info.sh
   ```
   Replace `YOUR_TIMEZONE` with your time zone (e.g., `America/New_York`).

## Usage

Run the main script with root privileges to set up the display:
```bash
sudo bash opizero-display.sh
```
Select the **automatic installation** option when prompted.

After installation, you can start the display script using the provided alias:
```bash
opidisplay
```

## Troubleshooting

**I2C device not detected**: Ensure the SSD1306 screen is properly connected and powered. Verify the I2C bus number using `i2cdetect`.