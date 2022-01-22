# azure-arm-104


### Github switch user local machine:

####  List your git config and view current user
1. git config --list
#### Change username and email global
2. git config  user.name "First Lastname"
3. git config  user.email "info@firstlastname.com"

### Repos switch to SSH:

https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories

Switching remote URLs from HTTPS to SSH
1. $ git remote -v (get urls)
2. Change your remote's URL from HTTPS to SSH with the git remote set-url command.
3. git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
4. $ git remote -v (verify that is has changed)

Generating a new SSH key
Paste the text below, substituting in your GitHub email address.

```sh
$ ssh-keygen -t ed25519 -C "your_email@example.com"
Generating public/private ed25519 key pair.
Enter file in which to save the key (/c/Users/johndoe/.ssh/id_ed25519):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /c/Users/johndoe/.ssh/id_ed25519
Your public key has been saved in /c/Users/johndoe/.ssh/id_ed25519.pub
The key fingerprint is:
```
Copy the SSH public key content to your clipboard from:
* id_ed25519.pub

Access the SSH folder like this
* cd ~/.ssh
* cat id_ed25519.pub

Go to Github->Profile->Settings->SSH and GPG keys
* SSH Key add new
* Title = a name
* Key = ctrl-v (the content in id_ed25519.pub)

Test connection to Github again and enter passphrase:
```sh
$ ssh -T git@github.com
Enter passphrase for key '/c/Users/johndoe/.ssh/id_ed25519':
Hi spawnmarvel! You've successfully authenticated, but GitHub does not provide shell access.
```

https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

### Adding or changing a passphrase:

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases

```sh
$ ssh-keygen -p -f ~/.ssh/id_ed25519
> Enter old passphrase: [Type old passphrase]
> Key has comment 'your_email@example.com'
> Enter new passphrase (empty for no passphrase): [Type new passphrase]
> Enter same passphrase again: [Repeat the new passphrase]
> Your identification has been saved with the new passphrase.
```

## Stuff about Azure, ARM, Powershell and more. Continued from 

https://github.com/spawnmarvel/azure-arm

## JSON, Powershell, ARM template, Bash (Wireshark, TCP viewer, Beartail).

[Azure Powershell] https://docs.microsoft.com/en-us/powershell/azure/?view=azps-6.3.0&viewFallbackFrom=azps-5.2.0

[Azure CLI] https://docs.microsoft.com/en-us/cli/azure/

### Structure

### Folders
1. AZ-104 Udemy S.D
*  ([Microsoft-Certified-Azure-Administrator-Associate] https://docs.microsoft.com/en-us/learn/certifications/azure-administrator/)
3. Compute
4. Storage
5. Network
6. Security
7. Powershell
8. [More-labs] https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/
9. Test

2. MS Learn 7
* Pre for administrators
* Manage identities and governance
* Implement and manage storage
* Deploy and manage compute resources
* Configure and manage virtual networks for administrators
* Monitor and back up resources


#### Good to know

[system-administrator] https://follow-e-lo.com/2021/10/29/system-administrator/

[typeperf] https://follow-e-lo.com/2021/02/10/disk-and-typeperf/

[netsh] https://follow-e-lo.com/2021/05/28/capture-traffic-wireshark/

[network-commands] https://github.com/spawnmarvel/azure-arm-104/blob/master/6_powershell/network_ps1_and_cmd.ps1

TCPView is a Windows program that will show you detailed listings of all TCP and UDP endpoints on your system, including the local and remote addresses and state of TCP connections.

If you cannot connect to a port, check if it is in use with TCPView and or telnet IP Port

[TCPView] https://docs.microsoft.com/en-us/sysinternals/downloads/tcpview

AppNetworkCounter is a simple tool for Windows that counts and displays the number of TCP/UDP bytes and packets sent and received by every application on your system

[AppNetworkCounter] https://www.nirsoft.net/utils/app_network_counter.html

Measure network activety for one .exe file:

[![Screenshot](x1-measure-network-activety-for-one-exe-file.jpg)


