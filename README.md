# wakeonlan

#### environment 
Apache
PHP

### on boot
~~~
#user apache
shell_exec("wakeonlan.sh ".$mac_address);
~~~

### is boot?
~~~
$res = shell_exec("ping -c 4 -W 5 ".$ip_address);
$array = explode("\n",$res);
if(strripos($res,'0 received') === false){
    $ping = "boot success";
}else{
    $ping = "boot faild";
}
~~~

### etc (ip address → mac address) and (mac address → ip address)
~~~
//ip address → mac address
if(isset($all['ip_address']) && $all['ip_address'] != ""){
    $mac = "";
    $pcs = shell_exec("nmap -sP {$all['ip_address']} ");
    $pcs = shell_exec("arp -a");
    $pcss = explode("\n",$pcs);

    foreach($pcss as $value){
        if(strripos($value,$all['ip_address']) !== false){
            if(preg_match("/([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}/",$value,$match) === 1){
                $mac = $match[0];
                break;
            }
        }
    }
    if($mac != ""){
        $ping = "　{$all['ip_address']} → MAC address　{$mac}";
    }else{
        $ping = "get faild";
    }
}
~~~

~~~
//mac address → ip address 
if(isset($all['mac_to_ip'])){
    if(isset($all['mac_address']) && $all['mac_address'] != ""){
        $ip = "";
        //192.168.6.* = user local segment
        $pcs = shell_exec("nmap -sP 192.168.6.* ");
        $pcs = shell_exec("arp -a");
        $pcss = explode("\n",$pcs);

        foreach($pcss as $value){
            if(strripos($value,$all['mac_address']) !== false){
                if(preg_match("/\(([a-zA-Z0-9.]+)\)/",$value,$match) === 1){
                    $ip = substr(substr($match[0],1),0,-1);
                    break;
                }
            }
        }
        if($ip != ""){
            $ping = "MAC address　{$all['mac_address']} → IP address　{$ip}";
        }else{
            $ping = "get faild";
        }
    }
}
~~~
