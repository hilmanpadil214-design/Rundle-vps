#!/bin/bash

# Warna untuk tampilan
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Fungsi untuk Menu Utama
main_menu() {
    clear
    echo -e "${GREEN}=======================================${NC}"
    echo -e "          RUNDLE STORE VPN             "
    echo -e "=======================================${NC}"
    echo " RAM: 333M/1.9G | Disk: 2.6G/59G"
    echo " Version: v2026.02.06-STABLE"
    echo "---------------------------------------"
    echo " 1) Create Account"
    echo " 2) Trial Account"
    echo " 3) Delete Account"
    echo " 4) Change Domain"
    echo " 5) List Accounts"
    echo " 0) Exit"
    echo "---------------------------------------"
    read -p " Enter your choice [0-5]: " choice

    case $choice in
        1) create_menu ;;
        2) echo "Fungsi Trial belum dibuat"; sleep 2; main_menu ;;
        3) echo "Fungsi Delete belum dibuat"; sleep 2; main_menu ;;
        4) echo "Fungsi Change Domain belum dibuat"; sleep 2; main_menu ;;
        5) echo "Fungsi List belum dibuat"; sleep 2; main_menu ;;
        0) exit 0 ;;
        *) echo "Pilihan tidak valid!"; sleep 1; main_menu ;;
    esac
}

# Fungsi untuk Sub-Menu Create Account
create_menu() {
    clear
    echo "---------------------------------------"
    echo " 1) Create Zivpn"
    echo " 2) Trial Zivpn"
    echo " 0) Back to Main Menu"
    echo "---------------------------------------"
    read -p " Enter your choice [0-2]: " sub_choice

    case $sub_choice in
        1) create_zivpn_account ;;
        2) echo "Trial Zivpn"; sleep 2; create_menu ;;
        0) main_menu ;;
        *) echo "Pilihan tidak valid!"; sleep 1; create_menu ;;
    esac
}

# Fungsi Eksekusi Pembuatan Akun
create_zivpn_account() {
    clear
    echo "------- Create New Zivpn Account -------"
    read -p " Enter new password: " vpn_password
    
    echo -e "${GREEN}Akun berhasil dibuat dengan password: $vpn_password${NC}"
    read -p "Tekan [Enter] untuk kembali ke menu..."
    main_menu
}

# Menjalankan menu utama saat script dieksekusi
main_menu
