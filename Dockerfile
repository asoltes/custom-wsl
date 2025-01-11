FROM ubuntu:22.04

# ARG WSL_USER=andresbukid
# ARG WSL_USER_HOME=/home/$WSL_USER
# ARG INSTALL_DIR=$WSL_USER_HOME

# update and upgrade the image with the latest packages
RUN apt-get -y update && apt-get -y upgrade

# prepare the distribution for interactivity
RUN echo 'y' | /usr/local/sbin/unminimize

# install useful distro plumbing
RUN apt-get -y install iptables lsof socat rsync gnupg wslu ntpdate show-motd command-not-found

# install the packages essential for development
RUN apt-get -y install apt-utils sudo debianutils build-essential pkg-config man-db bash-completion

# generate the en_US locale
RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8

# install useful commands
RUN apt-get -y install vim nano curl wget gzip unzip tcpdump jq git

# # Create user
# RUN useradd -ms /bin/bash $WSL_USER

# set the default timezone to Asia/Manila
RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Manila apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata
    
# delete the motd files that already exist
RUN rm /etc/update-motd.d/*

# oh my zsh configurations and as a default shell
RUN apt install zsh -y
RUN chsh -s $(which zsh)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# power10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# ohmyzsh plugins
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/fdellwing/zsh-bat.git  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf

#bash my aws
RUN git clone https://github.com/bash-my-aws/bash-my-aws.git ${BMA_HOME:-$HOME/.bash-my-aws}

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
RUN rm -rf awscliv2*

#terraform
RUN wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
RUN sudo apt update && sudo apt install terraform

#Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#OHhmyPosh
RUN curl -s https://ohmyposh.dev/install.sh | bash -s

#Run Pre-commit-hooks
RUN sudo apt update
RUN apt install -y unzip software-properties-common python3 python3-pip python-is-python3
RUN python3 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir pre-commit
RUN pip3 install --no-cache-dir checkov
RUN curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 "https://.+?-linux-amd64.tar.gz")" > terraform-docs.tgz && tar -xzf terraform-docs.tgz terraform-docs && rm terraform-docs.tgz && chmod +x terraform-docs && sudo mv terraform-docs /usr/bin/
RUN curl -L "$(curl -s https://api.github.com/repos/tenable/terrascan/releases/latest | grep -o -E -m 1 "https://.+?_Linux_x86_64.tar.gz")" > terrascan.tar.gz && tar -xzf terrascan.tar.gz terrascan && rm terrascan.tar.gz && sudo mv terrascan /usr/bin/ && terrascan init
RUN curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.zip")" > tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
RUN curl -L "$(curl -s https://api.github.com/repos/aquasecurity/tfsec/releases/latest | grep -o -E -m 1 "https://.+?tfsec-linux-amd64")" > tfsec && chmod +x tfsec && sudo mv tfsec /usr/bin/
RUN curl -L "$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep -o -E -i -m 1 "https://.+?/trivy_.+?_Linux-64bit.tar.gz")" > trivy.tar.gz && tar -xzf trivy.tar.gz trivy && rm trivy.tar.gz && sudo mv trivy /usr/bin
RUN curl -L "$(curl -s https://api.github.com/repos/minamijoyo/tfupdate/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.tar.gz")" > tfupdate.tar.gz && tar -xzf tfupdate.tar.gz tfupdate && rm tfupdate.tar.gz && sudo mv tfupdate /usr/bin/
RUN curl -L "$(curl -s https://api.github.com/repos/minamijoyo/hcledit/releases/latest | grep -o -E -m 1 "https://.+?_linux_amd64.tar.gz")" > hcledit.tar.gz && tar -xzf hcledit.tar.gz hcledit && rm hcledit.tar.gz && sudo mv hcledit /usr/bin/

#Install Granted
RUN curl -OL releases.commonfate.io/granted/v0.36.2/granted_0.36.2_linux_x86_64.tar.gz
RUN tar -zxvf ./granted_0.36.2_linux_x86_64.tar.gz -C /usr/local/bin/

# copy configuration files and bash initialization scripts
COPY ./etc/wsl.conf /etc/wsl.conf
# COPY ./etc/bash.bashrc /etc/bash.bashrc
# COPY ./etc/bash.d /etc/bash.d

# MOTD
RUN add-apt-repository ppa:wslutilities/wslu -y
RUN apt update -y
RUN apt install wslu -y
# RUN wslfetch

# copy executable files and scripts
COPY --chmod=0755 ./etc/update-motd.d /etc/update-motd.d
COPY --chmod=0755 ./files/register.sh /opt/register.sh
COPY --chmod=0755 ./files/.zshrc /root/.zshrc