# Network analysis with Docker containers

** FOR TRAINING PURPOSES ONLY **

You will be able to automate the Docker install if you don't have it, and automate creating containers to analyze with nmap.

So far, I've only got apache running on the clients, but will update as needed, or requested.

Based on the user input, the script will create a variable amount of containers, all running on different ports.

The ports range from 1000-10000. If you desire a different range, you can modify the ```dockerbuild.sh```.

# Hands on keyboards
2. We need to copy down the scripts.
```git clone https://github.com/bwithe/docker-nmap```

3. Let's cd in "docker-nmap" and execute the install and build script.
```sudo bash dockerbuild.sh```

4. Once we've done that, we can run ```sudo docker images``` to see our containers listed amongst the builds.

5. If we run ```sudo docker ps -a``` we shall see that our containers are successfully running.

6. Now, we can run ```sudo arp-scan -l --interface=docker0``` to see what IP's our containers are running and grab MAC addresses

7. Finally! Now that we've verified our IP ranges, we can use nmap on the containers and find the random ports the script first built!

