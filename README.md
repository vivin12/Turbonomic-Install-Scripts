# Turbonomic-Install-Scripts

This Bash script automates the process of pulling Turbonomic container images from IBM's Container Registry (ICR) and pushing them to a specified private container registry using Podman. It prompts the user for necessary credentials and handles the transfer of specified images.

## Prerequisites

- **Podman Installation:** Ensure that Podman is installed on your system. You can download and install it from the [official Podman website](https://podman.io/getting-started/installation)

- **IBM Cloud API Key:** Obtain your IBM Cloud API Key 

- **Private Registry Credentials:** Have the URL, username, and password for your private container registry ready. 

## Script Overview

The script performs the following steps:

1. **Prompt for IBM ICR Credentials:**
   - Requests the IBM Cloud API Key from the user. 
   - Logs into IBM ICR (`icr.io`) using the provided API Key.

2. **Prompt for Private Registry Credentials:**
   - Requests the URL, username, and password for the private registry.
   - Logs into the specified private registry using the provided credentials.

3. **Image Transfer Process:**
   - Defines a list of Turbonomic images and their respective versions.
   - For each image in the list:
     - Pulls the image from IBM ICR.
     - Tags the image for the private registry.
     - Pushes the tagged image to the private registry.

## Usage Instructions

1. **Download the Script:**
   - Save the script to your local machine, for example, as `transfer_images.sh`.

2. **Make the Script Executable:**
   - Open a terminal and navigate to the directory containing the script.
   - Run the following command to make the script executable:

     ```bash
     chmod +x transfer_images.sh
     ```

3. **Execute the Script:**
   - Run the script using the following command:

     ```bash
     ./transfer_images.sh
     ```

   - The script will prompt you to enter:
     - Your IBM Cloud API Key.
     - The URL of your private registry (e.g., `registry.example.com`).
     - Your private registry username.
     - Your private registry password.

4. **Monitor the Process:**
   - The script will display messages indicating the progress of pulling, tagging, and pushing each image.
   - Any errors encountered during the process will be displayed in the terminal.

## Important Notes

- **Error Handling:** The script includes basic error handling. If a login attempt fails, the script will exit with an error message. Similarly, if pulling, tagging, or pushing an image fails, the script will display an error message and continue with the next image.

- **Image List:** The script contains a predefined list of Turbonomic images and their versions. Ensure that this list matches the images you intend to transfer. You can modify the `IMAGES` array within the script to add or remove images as needed.

- **Security Considerations:** Handle your API keys and passwords with care. Do not hard-code sensitive information into the script. The script is designed to prompt for credentials at runtime to enhance security.

- **Podman vs. Docker:** This script uses Podman commands. If you prefer to use Docker, replace `podman` with `docker` in the script commands.

## Troubleshooting

- **Authentication Issues:** If you encounter authentication errors, verify that your API Key and registry credentials are correct. Ensure that your IBM Cloud account has the necessary permissions to access the required images.

- **Network Connectivity:** Ensure that your system has network access to `icr.io` and your private registry. Network issues can prevent the script from pulling or pushing images.

- **Podman Installation:** If you receive errors indicating that `podman` is not found, confirm that Podman is installed and properly configured on your system.

## License

This script is provided "as is" without warranty of any kind. Use it at your own risk. Ensure compliance with your organization's security policies and guidelines when handling container images and credentials.

---
