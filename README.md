This project is intended to create a simple CICD pipeline.

Below is the architecture


<img width="569" alt="image" src="https://github.com/user-attachments/assets/b94708ff-f888-4ab3-b02a-8ac77abb2cfa">

Steps involved:

1. Launch 3 ec2 instances
   i. 1 For each jenkins, ansible, docker
2. Install Docker on Ansible and webapp server
3. create ssh connection  so that jenkins server can talk to ansible and webserver, ansible server needs to talk to webserver.

   In jenkins server
   1. perform git checkout
       Open Jenkins- configure- Source code management-git-repository URL- (paste the git repo)
   3. push the files we got in jenkins through git checkout to Ansible server opt folder through passwordless authentication( dockerfile, playbook)
    
        build steps:
     i) Send files or execute commands over ssh
        SSH publishers
        Name - select the server( jenkins)
        Transfer set
            Exec command :   (rsync -avh /var/lib/jenkins/workspace/codepipeline/* ubuntu@172.31.31.21:/opt  )
        Advanced : verbose output
    ii) Send files or execute commands over ssh
        SSH publishers
        Name - select the server( Ansible)
        Transfer set
            Exec command :    cd /opt

      

   In Ansible
    1. Build Docker image
    2. push docker image to Docker hub

   web app:
   1. Run container on webapp server by pulling the same image from Docker hub.    
         

