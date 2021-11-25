#!/bin/zsh

nn_self_signed_openssl(){
    print -z 'openssl req -newkey rsa:4096 \\
            -x509 \\
            -sha256 \\
            -days 3650 \\
            -nodes \\
            -out example.crt \\
            -keyout example.key \\
            -subj "/C=SI/ST=Ljubljana/L=Ljubljana/O=Security/OU=IT Department/CN=www.example.com"'
}
nn_openssl_show_crt(){
    print -z 'openssl x509 -text -noout -in crt.crt'
}

nn_wpscan(){
    print -z 'wpscan -e "ap,at,u1-20,m1-50" --api-token XXX -o wpscan.log --url '
}

nn_dot_to_png(){
    print -z 'dot -Tpng in.dot -o out.png'
}


nn_qemu_img_vmdk(){
    print -z 'qemu-img convert -f vmdk -O qcow2 image.vmdk image.qcow2'
}

nn_qemu_img_vdi(){
    print -z 'qemu-img convert -f vdi -O qcow2 image.vdi image.qcow2'
}
nn_qemu_img_vhd_vpc(){
    print -z 'qemu-img convert -f vpc -O qcow2 image.vhd image.qcow2'
}
nn_qemu_img_clone(){
    print -z 'qemu-img create -f qcow2 -F qcow2 -b master.qcow2 clone.qcow2'
}
nn_qemu_create_disk(){
    print -z 'qemu-img create -f qcow2 disk.qcow2 XG'
}
nn_qemu_start(){
    print -z 'qemu-system-x86_64 -cdrom my.iso -boot menu=on -drive file=my.qcow2,format=qcow2 --enable-kvm -cpu host -m 1024'
}
nn_rdp(){
    print -z "xfreerdp /u:domain\\\\\\\\user /p:'password' /pth:password-hash  /w:1920 /h:1440  /proxy:socks5://localhost:1234 /v:10.60.14.46:3389"
}
nn_smb_mount() {
    print -z "sudo mount -t cifs -o username=user //ip/share ./mnt"
}
nn_r2_evm() {
    print -z "r2 -a evm -D evm 'evm://localhost:8545@0xcontracthash'"
}

