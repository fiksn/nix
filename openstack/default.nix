{ pkgs ? import <nixpkgs> {}, project, id, username, jmpHost }:

let 
   python = import ./requirements.nix { inherit pkgs; };
   pass = import ../os-password.nix;

   osHosts = pkgs.writeTextFile {
     name = "hosts";
     text = ''
       127.0.0.1 barbican.zrh.sportradar.ag cinder.zrh.sportradar.ag glance.zrh.sportradar.ag heat.zrh.sportradar.ag keystone.sportradar.ag neutron.zrh.sportradar.ag nova.zrh.sportradar.ag horizon.sportradar.ag 
     '';
   };

   squidConfig = pkgs.writeTextFile {
     name = "squid.conf";
     text = ''
       acl localnet src 10.0.0.0/8     # RFC1918 possible internal network
       acl localnet src 172.16.0.0/12  # RFC1918 possible internal network
       acl localnet src 192.168.0.0/16 # RFC1918 possible internal network
       acl localnet src fc00::/7       # RFC 4193 local private network range
       acl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines

       http_access allow localnet
       http_access allow localhost

       hosts_file ${osHosts}
       visible_hostname proxy
       access_log none
       http_port 3128
     '';
   };

   osProxyOn = pkgs.writeShellScriptBin "os-proxy-on" ''
     ${pkgs.openssh}/bin/ssh -L9311:10.208.2.12:9311 -L8776:10.208.2.12:8776 -L 9292:10.208.2.12:9292 -L8000:10.208.2.12:8000 -L8004:10.208.2.12:8004 -L35357:10.208.2.12:35357 -L5000:10.208.2.12:5000 -L9696:10.208.2.12:9696 -L8774:10.208.2.12:8774 -L1080:10.208.2.12:80 -L10443:10.208.2.12:443 ${jmpHost} -N&
     ${pkgs.squid}/bin/squid -f ${squidConfig} -N&
     export http_proxy=http://127.0.0.1:3128/
     export https_proxy=http://127.0.1:3128/    
   '';

   osProxyOff = pkgs.writeShellScriptBin "os-proxy-off" ''
     jobs -p | ${pkgs.findutils}/bin/xargs ${pkgs.coreutils}/bin/kill 
     unset http_proxy
     unset https_proxy
   '';

in

pkgs.stdenv.mkDerivation {
  name = "${project}-openstack";

  buildInputs = [
    osProxyOn
    osProxyOff
    pkgs.figlet
    pkgs.lolcat
    pkgs.coreutils
    pkgs.findutils
    python.packages."python-openstackclient"
    python.packages."python-novaclient"
    python.packages."python-cinderclient"
    python.packages."python-keystoneclient"
    python.packages."python-glanceclient"
    python.packages."python-heatclient"
    python.packages."python-swiftclient"
    python.packages."ipcalc"
    python.packages."ruamel-yaml"
    python.packages."deepdiff"
  ];

  shellHook = ''
    export OS_AUTH_URL=https://keystone.sportradar.ag:5000/v3
    export OS_PROJECT_ID=${id}
    export OS_PROJECT_NAME="${project}"
    export OS_USER_DOMAIN_NAME="Default"
    export OS_PROJECT_DOMAIN_ID="default"
    export OS_USERNAME="${username}"
    export OS_PASSWORD=$(echo "${pass}" | ${pkgs.coreutils}/bin/base64 -d | ${pkgs.coreutils}/bin/tr -d '\n')
    export OS_REGION_NAME="zrh"
    export OS_INTERFACE=public
    export OS_IDENTITY_API_VERSION=3
    alias proxy-on=". os-proxy-on"
    alias proxy-off=". os-proxy-off"
    alias osmr='openstack server list --long -c Name -c Host -c Flavor -c "Availabilty Zone" -c Status -c Networks'
    # openstack endpoint list -f value | grep zrh | cut -d" " -f 7 | sed 's/http.*:\/\///g' | cut -d '/' -f 1 | sort | uniq
    export PS1='\n\[\033[1;32m\][${project}-openstack:\w]\$\[\033[0m\] '
    figlet "$(echo ${project} | tr '[:lower:]' '[:upper:]') OpenStack" | lolcat --freq 0.5
    echo "From home you need to enable VPN and do 'proxy-on' before and 'proxy-off' after."
    echo "https://horizon.sportradar.ag:10443 should work for web"
  '';
}
