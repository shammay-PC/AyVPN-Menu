#!/bin/bash

# ##################################################################
#  Ay VPN Menu - All-in-One Script Manager
#
#  Author: Gemini AI for shammay (Ay Technic)
#  Version: 1.1.0
#  Website: shammay.ir
# ##################################################################

# --- Colors ---
RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[0;97m'
# --- End Colors ---

SCRIPT_NAME="ayvpn"
SCRIPT_PATH="/usr/local/bin/${SCRIPT_NAME}"
CURRENT_SCRIPT_PATH="$(realpath "$0")"

# ------------------------------------------------------------------
# Helper Functions
# ------------------------------------------------------------------

# Function to display the header ASCII art
show_banner() {
    echo -e "${CYAN}"
    echo "+=======================================+"
    echo "|     _          __     ______  _   _   |"
    echo "|    / \  _   _  \ \   / /  _ \| \ | |  |"
    echo "|   / _ \| | | |  \ \ / /| |_) |  \| |  |"
    echo "|  / ___ \ |_| |   \ V / |  __/| |\  |  |"
    echo "| /_/   \_\__, |    \_/  |_|   |_| \_|  |"
    echo "|         |___/                         |"
    echo "+=======================================+"
    echo -e "${RESET}"
}

# Function to wait for user input
press_any_key() {
    echo ""
    read -p "Operation successful. Press any key to return to the menu..." -n 1 -r
}

# Function to handle successful messages
handle_success() {
    echo -e "${GREEN}${1:-Operation successful.}${RESET}"
    press_any_key
}

# Function to handle error messages
handle_error() {
    echo -e "${RED}${1:-An error occurred.}${RESET}"
    press_any_key
}

# ------------------------------------------------------------------
# Installation Function
# ------------------------------------------------------------------
install_script() {
    echo -e "${YELLOW}It seems this is the first time running the script.${RESET}"
    read -p "Would you like to install the '${SCRIPT_NAME}' command as a permanent shortcut? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        if cp "${CURRENT_SCRIPT_PATH}" "${SCRIPT_PATH}" && chmod +x "${SCRIPT_PATH}"; then
            echo -e "${GREEN}Installation successful! You can now run the menu by just typing '${SCRIPT_NAME}'.${RESET}"
            sleep 3
        else
            echo -e "${RED}Installation failed! Please run the script with root privileges (sudo).${RESET}"
            sleep 3
        fi
    fi
}

# ------------------------------------------------------------------
# Submenu & Action Functions
# ------------------------------------------------------------------

### --- Ay VPN Projects Submenus ---

submenu_v2ray_sub() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- Ay-v2Ray-Subscription Menu ---${RESET}"
        echo -e "${CYAN}1)${RESET} Install"
        echo -e "${MAGENTA}2)${RESET} Menu"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Previous Menu"
        read -p "Please select an option: " choice

        case $choice in
            1)
                bash <(curl -sSL https://raw.githubusercontent.com/shammay-PC/Ay-v2Ray-Subscription/main/setup.sh) install
                handle_success
                ;;
            2)
                ay-sub
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}

submenu_xui_theme() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- Ay X-UI Subscription Theme Menu ---${RESET}"
        echo -e "${CYAN}1)${RESET} Install"
        echo -e "${MAGENTA}2)${RESET} Renew X-UI sub.html"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Previous Menu"
        read -p "Please select an option: " choice

        case $choice in
            1)
                bash <(curl -Ls https://raw.githubusercontent.com/shammay-PC/Ay-X-UI-Theme/master/install.sh)
                handle_success
                ;;
            2)
                rm -r /etc/x-ui/html/sub.html && nano /etc/x-ui/html/sub.html
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}

submenu_psiphon() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- Ay-pSiphon Menu ---${RESET}"
        echo -e "${CYAN}1)${RESET} Install"
        echo -e "${MAGENTA}2)${RESET} Change Region"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Previous Menu"
        read -p "Please select an option: " choice

        case $choice in
            1)
                wget https://raw.githubusercontent.com/shammay-PC/Ay-pSiphon/main/Ay-pSiphon && sh Ay-pSiphon
                handle_success
                ;;
            2)
                nano /etc/Ay-pSiphon/pSiphon.config
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}

### --- Other Submenus ---

submenu_nginx() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- NginX Menu ---${RESET}"
        echo -e "${CYAN}1)${RESET} Install"
        echo -e "${MAGENTA}2)${RESET} Change Nginx Port:80"
        echo -e "${CYAN}3)${RESET} Edit /etc/***/shammay.ir"
        echo -e "${MAGENTA}4)${RESET} NginX Reload & TEST"
        echo -e "${CYAN}5)${RESET} NginX Check & TEST"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Main Menu"
        read -p "Please select an option: " choice

        case $choice in
            1)
                apt install nginx-full && apt install nginx-extras && apt install nginx-core && apt install nginx-light
                handle_success
                ;;
            2)
                nano /etc/nginx/sites-enabled/default
                handle_success
                ;;
            3)
                nano /etc/nginx/sites-available/shammay.ir
                handle_success
                ;;
            4)
                systemctl daemon-reload && systemctl restart nginx
                handle_success
                ;;
            5)
                nginx -t && systemctl status nginx
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}

submenu_libertea() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- Libertea Menu ---${RESET}"
        echo -e "${CYAN}1)${RESET} Install"
        echo -e "${MAGENTA}2)${RESET} Restart Libertea-Haproxy"
        echo -e "${CYAN}3)${RESET} Update"
        echo -e "${MAGENTA}4)${RESET} Uninstall"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Main Menu"
        read -p "Please select an option: " choice

        case $choice in
            1)
                curl -s https://raw.githubusercontent.com/VZiChoushaDui/Libertea/master/bootstrap.sh -o /tmp/bootstrap.sh && bash /tmp/bootstrap.sh install
                handle_success
                ;;
            2)
                docker restart libertea-haproxy
                handle_success
                ;;
            3)
                curl -s https://raw.githubusercontent.com/VZiChoushaDui/Libertea/master/bootstrap.sh -o /tmp/bootstrap.sh && bash /tmp/bootstrap.sh update
                handle_success
                ;;
            4)
                curl -s https://raw.githubusercontent.com/VZiChoushaDui/Libertea/master/bootstrap.sh -o /tmp/bootstrap.sh && bash /tmp/bootstrap.sh uninstall
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}

submenu_rclocal() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- rc.local Menu ---${RESET}"
        echo -e "${CYAN}1)${RESET} SET rc.local"
        echo -e "${MAGENTA}2)${RESET} chmod rc.local"
        echo -e "${CYAN}3)${RESET} Edit rc.local"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Main Menu"
        read -p "Please select an option: " choice

        case $choice in
            1)
                cat << 'EOF' > /etc/rc.local
#!/bin/bash
hostname S8H-US-AEZA
psiphon
exit 0
EOF
                handle_success "File /etc/rc.local was successfully created/overwritten."
                ;;
            2)
                chmod +x /etc/rc.local
                handle_success
                ;;
            3)
                nano /etc/rc.local
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}


# ------------------------------------------------------------------
# Main Menu Definitions
# ------------------------------------------------------------------

menu_ay_vpn_projects() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}--- Ay VPN Projects ---${RESET}"
        echo -e "${CYAN}1)${RESET} Ay-v2Ray-Subscription"
        echo -e "${MAGENTA}2)${RESET} Ay X-UI Subscription Theme"
        echo -e "${CYAN}3)${RESET} Ay-pSiphon"
        echo -e "${MAGENTA}4)${RESET} Sync X-UI Expiry_Time"
        echo "------------------------------------"
        echo -e "${WHITE}0)${RESET} Return to Main Menu"
        read -p "Please select an option: " choice

        case $choice in
            1) submenu_v2ray_sub ;;
            2) submenu_xui_theme ;;
            3) submenu_psiphon ;;
            4)
                sqlite3 /etc/x-ui/x-ui.db "
UPDATE client_traffics
SET expiry_time = (
   SELECT parent.expiry_time
   FROM client_traffics AS parent
   WHERE
       client_traffics.email LIKE '%' || parent.email || '%'
       AND client_traffics.email != parent.email
   ORDER BY LENGTH(parent.email) DESC
   LIMIT 1
)
WHERE EXISTS (
   SELECT 1
   FROM client_traffics AS parent
   WHERE
       client_traffics.email LIKE '%' || parent.email || '%'
       AND client_traffics.email != parent.email
);
"
                handle_success
                ;;
            0)
                break
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}

# ##################################################################
# <<<<<<<<<<<<<<<<<<<<<<<< MAIN MENU >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ##################################################################
main_menu() {
    while true; do
        clear
        show_banner
        echo -e "${YELLOW}=============== Ay VPN Menu ===============${RESET}"
        
        # --- Categories ---
        echo -e "${CYAN}1)${RESET} Ay VPN Projects"
        echo -e "${MAGENTA}2)${RESET} NginX"
        echo -e "${CYAN}3)${RESET} Libertea"
        echo -e "${MAGENTA}4)${RESET} rc.local"
        
        echo ""
        echo -e "${YELLOW}--- System & Core Utilities ---${RESET}"
        echo -e "${CYAN}5)${RESET} Update/Upgrade"
        echo -e "${MAGENTA}6)${RESET} Fix Missings"
        echo -e "${CYAN}7)${RESET} Install ZIP/UNZIP"
        echo -e "${MAGENTA}8)${RESET} S W A P  4.7G"
        
        echo ""
        echo -e "${YELLOW}--- Network & Security ---${RESET}"
        echo -e "${CYAN}9)${RESET} SSH Port > 2208"
        echo -e "${MAGENTA}10)${RESET} Warp-Plus"
        echo -e "${CYAN}11)${RESET} x-ui-pro > TX-UI"
        
        # ADD NEW MAIN MENU ITEMS HERE
        
        echo "------------------------------------"
        echo -e "${RED}0) Exit${RESET}"
        read -p "Please select an option: " choice

        case $choice in
            # --- Categories ---
            1) menu_ay_vpn_projects ;;
            2) submenu_nginx ;;
            3) submenu_libertea ;;
            4) submenu_rclocal ;;
            
            # --- System & Core Utilities ---
            5)
                apt update && apt upgrade -y
                handle_success
                ;;
            6)
                apt autoremove
                apt --fix-broken install
                apt-get update --fix-missing
                dpkg --configure -a
                handle_success
                ;;
            7)
                apt install zip && apt install unzip -y
                handle_success
                ;;
            8)
                fallocate -l 4.7G /S8H-SWAP
                chmod 600 /S8H-SWAP
                mkswap /S8H-SWAP
                swapon /S8H-SWAP
                echo '/S8H-SWAP         swap         swap        defaults        0        0' >> /etc/fstab
                handle_success
                ;;

            # --- Network & Security ---
            9)
                echo "port 2208" >> /etc/ssh/sshd_config && systemctl reload sshd
                handle_success
                ;;
            10)
                bash <(curl -fsSL https://raw.githubusercontent.com/bepass-org/warp-plus/master/termux.sh)
                handle_success
                ;;
            11)
                sudo su -c "$(command -v apt||echo dnf) -y install wget;bash <(wget -qO- raw.githubusercontent.com/GFW4Fun/x-ui-pro/master/x-ui-pro.sh) -panel 3 -xuiver last -cdn off -secure no -country xx"
                handle_success
                ;;
            
            # ADD NEW MAIN MENU ACTIONS HERE

            0)
                echo "Exiting..."
                exit 0
                ;;
            *)
                handle_error "Invalid option!"
                ;;
        esac
    done
}


# ------------------------------------------------------------------
# Script Entry Point
# ------------------------------------------------------------------

# Check if script is running as root
if [ "$(id -u)" -ne 0 ]; then
   echo -e "${RED}This script must be run as root. Please use 'sudo'.${RESET}"
   exit 1
fi

# Check if the shortcut exists
if [ ! -f "${SCRIPT_PATH}" ]; then
    install_script
fi

# Start the main menu
main_menu