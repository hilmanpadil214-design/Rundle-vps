#!/bin/bash

# Warna untuk tampilan
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Mengambil IP Public VPS secara otomatis
MYIP=$(wget -qO- icanhazip.com; echo "127.0.0.1")
DOMAIN="bisa.diisi.domain.kamu" # Nanti bisa kamu ganti sesuai domainmu

# Fungsi untuk Menu Utama
main_menu() {
    clear
    echo -e "${GREEN}=======================================${NC}"
    echo -e "          RUNDLE STORE VPN             "
    echo -e "=======================================${NC}"
    echo " RAM: $(free -m | awk 'NR==2{print $3}')M/$(free -m | awk 'NR==2{print $2}')M | Disk: $(df -h / | awk 'NR==2{print $3}')/$(df -h / | awk 'NR==2{print $2}')"
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
    echo " 1) Create Zivpn / SSH Account"
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

# Fungsi Eksekusi Pembuatan Akun Asli di VPS
create_zivpn_account() {
    clear
    echo "------- Create New Zivpn Account -------"
    read -p " Username : " user
    
    # Cek apakah username sudah ada di VPS
    if id "$user" &>/dev/null; then
        echo -e "${YELLOW}Username '$user' sudah ada! Silakan pakai nama lain.${NC}"
        sleep 2
        create_zivpn_account
    fi

    read -p " Password : " vpn_password
    read -p " Expired (Hari): " masa_aktif

    # Perintah Linux untuk membuat user asli di sistem VPS
    useradd -e $(date -d "$masa_aktif days" +"%Y-%m-%d") -s /bin/false "$user"
    echo "$user:$vpn_password" | chpasswd

    # Menghitung tanggal kadaluarsa
    exp_date=$(date -d "$masa_aktif days" +"%d-%b-%Y")

    # Menampilkan detail akun lengkap yang bisa dicopas user
    clear
    echo -e "${GREEN}=======================================${NC}"
    echo -e "      ZIVPN / SSH ACCOUNT DETAILS      "
    echo -e "=======================================${NC}"
    echo -e " Host/IP   : $MYIP"
    echo -e " Domain    : $DOMAIN"
    echo -e " Username  : $user"
    echo -e " Password  : $vpn_password"
    echo -e " Created   : $(date +"%d-%b-%Y")"
    echo -e " Expired   : $exp_date ($masa_aktif Hari)"
    echo -e "=======================================${NC}"
    echo -e " Port SSH  : 22, 143"
    echo -e " Port Drop : 109, 7300"
    echo -e "${GREEN}=======================================${NC}"
    
    read -p "Tekan [Enter] untuk kembali ke menu..."
    main_menu
}

# Menjalankan menu utama saat script dieksekusi
main_menu
