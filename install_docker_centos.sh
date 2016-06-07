if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
yum update

yum install -y docker-engine
service docker start
