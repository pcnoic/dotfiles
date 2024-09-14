# OS and Architecture Detection
ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        DETECTED_ARCH := AMD64
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            DETECTED_ARCH := AMD64
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            DETECTED_ARCH := IA32
        endif
    endif
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        DETECTED_OS := Linux
    endif
    ifeq ($(UNAME_S),Darwin)
        DETECTED_OS := macOS
    endif
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        DETECTED_ARCH := AMD64
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        DETECTED_ARCH := IA32
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        DETECTED_ARCH := ARM
    endif
endif

# Determine Linux Distribution
ifeq ($(DETECTED_OS),Linux)
    DISTRO := $(shell lsb_release -si 2>/dev/null || cat /etc/os-release | grep ^ID= | cut -d= -f2)
endif

.PHONY: all install detect-os run-ansible install-ansible install-homebrew

all: install

install: detect-os install-ansible install-ansible-dependencies run-ansible

detect-os:
	@echo "Detected OS: $(DETECTED_OS)"
	@echo "Detected Architecture: $(DETECTED_ARCH)"
	@if [ "$(DETECTED_OS)" = "Linux" ]; then \
		echo "Detected Linux Distribution: $(DISTRO)"; \
	fi

install-ansible: detect-os
	@case "$(DETECTED_OS)" in \
		macOS) \
			echo "Installing Ansible on macOS..."; \
			$(MAKE) install-homebrew; \
			brew install ansible; \
			;; \
		Linux) \
			case "$(DISTRO)" in \
				Ubuntu|Debian) \
					echo "Installing Ansible on $(DISTRO)..."; \
					sudo apt update; \
					sudo apt install -y software-properties-common; \
					sudo apt-add-repository --yes --update ppa:ansible/ansible; \
					sudo apt install -y ansible; \
					;; \
				Fedora) \
					echo "Installing Ansible on Fedora..."; \
					sudo dnf install -y ansible; \
					;; \
				*) \
					echo "Unsupported Linux distribution for Ansible installation: $(DISTRO)"; \
					exit 1; \
					;; \
			esac \
			;; \
		Windows) \
			echo "Ansible installation on Windows is not supported by this Makefile."; \
			exit 1; \
			;; \
		*) \
			echo "Unsupported OS for Ansible installation: $(DETECTED_OS)"; \
			exit 1; \
			;; \
	esac

install-homebrew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		if [ -f /opt/homebrew/bin/brew ]; then \
			echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile; \
			eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		elif [ -f /usr/local/bin/brew ]; then \
			echo 'eval "$$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile; \
			eval "$$(/usr/local/bin/brew shellenv)"; \
		fi; \
	else \
		echo "Homebrew is already installed."; \
	fi

install-ansible-dependencies:
	ansible-galaxy install darkwizard242.lazygit
	ansible-galaxy install pandemonium1986.k9s
	ansible-galaxy install taktus.fzf

run-ansible:
	cd ansible && ansible-playbook -i inventory/localhost \
		-e "detected_os=$(DETECTED_OS)" \
		-e "detected_distro=$(DISTRO)" \
		-e "is_macos=$(shell [ "$(DETECTED_OS)" = "macOS" ] && echo true || echo false)" \
		-e "is_linux=$(shell [ "$(DETECTED_OS)" = "Linux" ] && echo true || echo false)" \
		playbooks/main.yml
