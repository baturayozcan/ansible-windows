#!/bin/bash
#echo -e "\e[96m 888888b.   d8b                        d8b 888 888          888      d8b                          888                                      d8b                          888      d8b               \e[39m"
#echo -e "\e[96m 888  888b  Y8P                        Y8P 888 888          888      Y8P                          888                                      Y8P                          888      Y8P               \e[39m"
#echo -e "\e[96m 888  888P                                 888 888          888                                   888                                                                   888                        \e[39m"
#echo -e "\e[96m 8888888K.  888 .d8888b  88888b.d88b.  888 888 888  8888b.  88888b.  888 888d888 888d888  8888b.  88888b.  88888b.d88b.   8888b.  88888b.  888 888d888 888d888  8888b.  88888b.  888 88888b.d88b.  \e[39m"
#echo -e "\e[96m 888  8Y88b 888 88K      888 8888 888b 888 888 888     888b 888 888b 888 888PP   888PP       888b 888 888b 888 8888 888b     888b 888 888b 888 888P8   888P8       888b 888 888b 888 888 8888 888b \e[39m"
#echo -e "\e[96m 888    888 888 YY8888b. 888  888  888 888 888 888 .d888888 888  888 888 888     888     .d888888 888  888 888  888  888 .d888888 888  888 888 888     888     .d888888 888  888 888 888  888  888 \e[39m"
#echo -e "\e[96m 888   d88P 888      X88 888  888  888 888 888 888 888  888 888  888 888 888     888     888  888 888  888 888  888  888 888  888 888  888 888 888     888     888  888 888  888 888 888  888  888 \e[39m"
#echo -e "\e[96m 8888888PP  888  88888P' 888  888  888 888 888 888 4Y888888 888  888 888 888     888     4Y888888 888  888 888  888  888 4Y888888 888  888 888 888     888     4Y888888 888  888 888 888  888  888 \e[39m"
#echo -e "\e[92m======================================= \e[39m"
#echo -e "\e[92m simdi dicekler ickiliydi bilmem ne \e[39m"
#echo -e "\e[92m======================================= \e[39m"
#echo -e "\e[92mAre you ready bitchez?\e[39m"
#sleep 1
#echo -e "\e[92m3 ...\e[39m"
#sleep 1
#echo -e "\e[92m2 ....\e[39m"
#sleep 1
#echo -e "\e[92m1 .....\e[39m"
#sleep 1
#printf "\033c"
echo -e "\e[92mPlaybooks to Run (Select 1-14): \e[39m"
echo -e "\e[92m1. Ping\n2. Create User\n3. Create Directory\n4. Copy File\n5. Compress/Delete MT4 Logs\n6. Install .NET Framework\n7. Install Winrar\n8. Install Pscx\n9. Install AWS Tools\n10.Install Windows Updates\n11.Restart Windows\n12.Do Weekly Maintenance\n13.Upload MT4 Logs to S3\n14.Update Windows Management Framework\e[39m"
read var_userChoice
case $var_userChoice in
    1) var_playbook=ping.yml ;;
    2) var_playbook=create_user.yml ;;
    3) var_playbook=create_directory.yml ;;
    4) var_playbook=copy_file.yml ;;
    5) var_playbook=compress_delete_MT4logs.yml ;;
    6) var_playbook=install_dotnet.yml ;;
    7) var_playbook=install_rar.yml ;;
    8) var_playbook=install_pscx.yml ;;
    9) var_playbook=install_AWSTools.yml ;;
    10) var_playbook=install_win_updates.yml ;;
    11) var_playbook=restart_windows.yml ;;
    12) var_playbook=weekly.yml ;;
    13) var_playbook=upload_MT4logs_to_S3.yml ;;
    14) var_playbook=install_wmf.yml ;;
    *) echo -e "\e[91mSACMALADIN!\nBi sans daha veriyorum, tekrar dene.\e[39m" ; sh /etc/ansible/run_playbook.sh ; exit 0 ;;
esac
if [ "$var_playbook" == "copy_file.yml" ]
then
    echo -e "\e[92mEnter File Name (including extension) to Be Copied: \e[39m"
    read var_filename
elif [ "$var_playbook" == "create_directory.yml" ]
then
    echo -e "\e[92mEnter Full Path of Directory Name to Be Created: \e[39m"
    read var_dir_path
elif [ "$var_playbook" == "create_user.yml" ]
then
    echo -e "\e[92mEnter User Name to Be Created: \e[39m"
    read var_user_name
    echo -e "\e[92mEnter User Password to Be Created: \e[39m"
    read var_user_password
fi
echo -e "\e[92mSelect Hosts: \e[39m"
echo -e "\e[92m1. Prod\n2. Watch Dogs (ooming soon)\n3. Data Centers (coming soon)\n4. UAT (coming soon)\n5. Test (coming soon)\e[39m"
read var_hosts
case $var_hosts in
    1) var_hosts="prod" ;;
    2) var_hosts="wd" ; echo -e "\e[91mComing soon dedik ya birader why so israr?Bastan bastan ...\e[39m" ; exit 0 ;;
    3) var_hosts="dc" ; echo -e "\e[91mComing soon dedik ya birader why so israr?Bastan bastan ...\e[39m" ; exit 0 ;;
    4) var_hosts="uat" ; echo -e "\e[91mComing soon dedik ya birader why so israr?Bastan bastan ...\e[39m" ; exit 0 ;;
    5) var_hosts="test" ; echo -e "\e[91mComing soon dedik ya birader why so israr?Bastan bastan ...\e[39m" ; exit 0 ;;
    *) echo -e "\e[91mOops.. Bazi seyler cok yanlis gitti.\nBastan calistirman lazim bebeyim.\e[39m" ; exit 0 ;;
esac
if [ "$var_playbook" == "copy_file.yml" ]
then
    sudo ansible-playbook /etc/ansible/playbooks/$var_playbook --extra-vars "hosts=$var_hosts filename=$var_filename" --vault-password-file /etc/ansible/vault_pass
elif [ "$var_playbook" == "create_directory.yml" ]
then
    sudo ansible-playbook /etc/ansible/playbooks/$var_playbook --extra-vars "hosts=$var_hosts dir_path=$var_dir_path" --vault-password-file /etc/ansible/vault_pass
elif [ "$var_playbook" == "create_user.yml" ]
then
    sudo ansible-playbook /etc/ansible/playbooks/$var_playbook --extra-vars "hosts=$var_hosts user_name=$var_user_name user_password=$var_user_password" --vault-password-file /etc/ansible/vault_pass
else
    sudo ansible-playbook /etc/ansible/playbooks/$var_playbook --extra-vars "hosts=$var_hosts" --vault-password-file /etc/ansible/vault_pass
fi
