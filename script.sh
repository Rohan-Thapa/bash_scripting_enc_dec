#!/bin/bash

figlet ENC / DEC TOOL
rohan_tool(){
echo "Do you want to encrypt or decrypt a file? "
sleep 1
echo "Enter 'e' for encryption, 'd' for decryption and 'q' to quit"
read first_input

if [[ $first_input == "q" ]]; then 
        echo -n "Exiting the program."
        sleep 1
        echo -n "."
        sleep 1
        echo "."
        echo "Thank you!!"
        sleep 1
        exit

elif [[ $first_input == "e" ]]; then
        function exist_create(){
        echo "Enter '1' if the file exists and '2' if you want to create a file."
        read exists_or_create
        if [[ $exists_or_create == '2' ]]; then
                echo -n "Name the file: "
                read file_name
                echo "Enter the content in the file."
                read new_file_content
                echo "$new_file_content" > $file_name
        elif [[ $exists_or_create == '1' ]]; then
                echo -n "Enter the file name: "
                read file_name

                echo "Reading the content of your file: "
                sleep 1
                cat $file_name                                                                                                                                                                                                             
        else                                                                                                                                                                                                                               
                echo "Wrong input format.!!"                                                                                                                                                                                               
                sleep 1                                                                                                                                                                                                                    
                exist_create                                                                                                                                                                                                               
        fi                                                                                                                                                                                                                                 
        }                                                                                                                                                                                                                                  
        exist_create                                                                                                                                                                                                                       
        sleep 1                                                                                                                                                                                                                            
        echo -n "Name the file where you want to store the encrypted content: "                                                                                                                                                            
        read encrypted_file_name                                                                                                                                                                                                           
        sleep 1                                                                                                                                                                                                                            
        encryption_process(){
                echo "Do you want to use asymmetric key encryption or symmetric key encryption [a/s]: "
                read enc_type
                if [[ $enc_type == 'a' ]]; then
                        echo -n "Encrypting the "
                        sleep 1
                        echo -n "f"
                        sleep 1
                        echo -n "i"
                        sleep 1
                        echo -n "l"
                        sleep 1
                        echo "e"
                        sleep 1
                        openssl genrsa -out privatekey 1024
                        openssl rsa -in privatekey -out publickey -pubout >& /dev/null
                        openssl pkeyutl -encrypt -in $file_name -inkey publickey -pubin -out $encrypted_file_name 
                        echo "'$file_name' has been encrypted to the file named '$encrypted_file_name'"
                        sleep 1
                        echo "Redirecting..."
                        sleep 1
                        rohan_tool

                elif [[ $enc_type == 's' ]]; then
                        echo -n "Enter a passphrase for the encryption: "
                        stty -echo
                        read password
                        stty echo
                        echo ""
                        echo  "Which algorithm do you want to use?"
                        echo "aes-256-cbc" > enc_algrthm.txt
                        echo "aes-192-ecb" >> enc_algrthm.txt
                        echo "des-cbc" >> enc_algrthm.txt
                        echo "bf-cbc" >> enc_algrthm.txt
                        echo "seed" >> enc_algrthm.txt
                        cat -n enc_algrthm.txt
                        read in_algrthm
                        nu=$(sed -n $in_algrthm"p" enc_algrthm.txt)
                        openssl enc -$nu -in $file_name -out $encrypted_file_name -k $password >& /dev/null
                        echo -n "."
                        sleep 1
                        echo -n "."
                        sleep 1
                        echo -n "."
                        sleep 1
                        echo "Encryption successfull."
                        sleep 1
                        echo "Redirecting..."
                        sleep 1
                        rohan_tool
                else
                        echo "Wrong input format!!"
                        sleep 1
                        encryption_process

                fi
        }
        encryption_process
elif [[ $first_input == 'd' ]]; then
        echo "Which file do you want to decrypt? "
        read file_to_decr
        sleep 1
        echo "In which file do you want the decrypted file to be stored? "
        read decr_file
        sleep 1
        echo -n "Enter 'a' if asymmetric key is used while encryption and 's' if symmetric key is used: "
        read encr_key
        if [[ $encr_key == 'a' ]]; then
                openssl pkeyutl -decrypt -in $file_to_decr -out $decr_file -inkey privatekey 
                sleep 1
                echo "Reading the content of the decrypted data,"
                sleep 1
                cat $decr_file
        elif [[ $encr_key == 's' ]]; then
                echo -n "Enter the password: "
                read password
                echo "Which algorithm was used during encryption? "
                        cat -n enc_algrthm.txt
                        read in_algrthm
                        nu=$(sed -n $in_algrthm"p" enc_algrthm.txt)
                        openssl $nu -d -in $file_to_decr -out $decr_file -k $password >& /dev/null
                        sleep 1
                        echo "Reading the content of the decrypted file."
                        cat $decr_file
        else
                echo "Wrong input was given."
                rohan_tool
        fi
else
        echo "We can only encrypt or decrpty the file. The input given was invalid."
        echo "Re-running the script again."
        rohan_tool
fi

}

rohan_tool
