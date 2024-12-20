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
            Exec command :   
                              cd /opt
                              **docker image build -t $JOB_NAME.v1.$BUILD_ID .**
                              #Builds a Docker image using the Dockerfile in the current directory (.).
                              #-t tags the image with a name and version:
                              #$JOB_NAME: The name of the job or application, typically set as an environment variable in Jenkins.
                              #v1.$BUILD_ID: Version v1 and the current Jenkins build ID.
                              **docker image tag $JOB_NAME.v1.$BUILD_ID vaidikprabhu/$JOB_NAME.v1.$BUILD_ID**
                              #Creates a new tag for the image to associate it with your Docker Hub account (vaidikprabhu).
                              #The new tag format is vaidikprabhu/$JOB_NAME.v1.$BUILD_ID.
                              **docker image tag $JOB_NAME.v1.$BUILD_ID vaidikprabhu/$JOB_NAME:latest**
                              #Tags the same image with the latest tag for easy reference.
                              #The latest tag usually points to the most recent stable version of the image.
                              **docker image push vaidikprabhu/$JOB_NAME.v1.$BUILD_ID**
                              #Pushes the versioned image (vaidikprabhu/$JOB_NAME.v1.$BUILD_ID) to Docker Hub.
                              #This makes the image available for download and use from your Docker Hub repository.
                              **docker image push vaidikprabhu/$JOB_NAME:latest**
                              #Pushes the latest tagged version of the image to Docker Hub.
                              **docker image rmi $JOB_NAME.v1.$BUILD_ID vaidikprabhu/$JOB_NAME.v1.$BUILD_ID vaidikprabhu/$JOB_NAME:latest**
                              #Removes the specified images from the local Docker environment to save space
                              $JOB_NAME.v1.$BUILD_ID: The local build tag.
                              vaidikprabhu/$JOB_NAME.v1.$BUILD_ID: The versioned tag for Docker Hub.
                              vaidikprabhu/$JOB_NAME:latest: The latest tag for Docker Hub.
         Advanced : verbose output
    iIi) Send files or execute commands over ssh
        SSH publishers
        Name - select the server( Ansible)
        Transfer set
            Exec command :   ansible-playbook /opt/webapp.yml

      

   In Ansible
    1. Build Docker image
    2. push docker image to Docker hub

   web app:
   1. Run container on webapp server by pulling the same image from Docker hub.    
         

