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
